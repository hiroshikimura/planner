# frozen_string_literal: true

# 一番最初に「近場のノードで作業を完了するロボット」を検索して、すべてのノードを網羅する
class PlanningMinWorkingService
  attr_reader :plan

  def initialize(_params)
    @plan = Plan.with_all.find_by(job_id: @params[:id])
  end

  def call
    completed_robots = []

    while node_exists? && (target_robot_with_node = find_next_robot)
      # 見つかった
      plan.ways.create(target_robot_with_node)
    end
  end

  def possible_robot_exists?(completed_robots)
    # 移動可能なロボットが存在するか
    plan.robots.reject { |r| completed_robots.pluck(:id).include?(r.id) }.present?
  end

  def node_exists?
    # 移動可能なノードが存在するか
    plan.nodes.reject { |n| plan.ways.pluck(:node_id).include?(n.id) }.present?
  end

  def distance(robot, node)
    CalcDistanceService.calculate_distance(robot.latest_point&.node || robot, [node])
  end

  def find_next_robot
    plan.robots
      .select { |r| r.latest_leave_at <= r.end_time }
      .map { |r| robot_next_move_to(r) }
      .min_by { |e| e[:leave_at] }
  end

  def robot_next_move_to(robot)
    next_node = near_by(r, find_of(r))
    arrival_at = robot.latest_leave_at + moving_time(robot, node)
    {
      robot: robot,
      node: next_node,
      arrival_at: arrival_at,
      leave_at: arrival_at + next_node.time_required.second
    }
  end

  def moving_time(robot, node)
    distance(robot, node) / speed(robot, node)
  end

  def next_robot(completed_robots)
    plan
      .robots
      .activated(current_time)
      .where.not(id: completed_robots.pluck(:id))
      .min_by(&:latest_leave_at)
  end

  def speed(_robot, _node)
    # m/sec
    5.0 * 1000 / (1 * 60 * 60.0) * 0.8
  end

  def find_of(robot)
    Node
      .find_of(robot.areas)
      .where.not(id: plan.ways.pluck(:node_id))
  end

  def near_by(robot, nodes)
    n = Node
        .select('*, ST_Distance(position, :position) AS distance', robot.latest_location)
        .where(id: nodes.select(:id))
        .order(distance: :asc)
        .first
    nodes.find_by(id: n.id)
  end

  def current_time
    not_action_robots = plan.robots.reject { |r| plan.ways.map(:borot_id).include?(r.id) }
    (
      plan.ways.map { |way| way.arrival_at + way.node.time_required }.max +
      not_action_robots.map(&:start_time)
    ).min
  end
end
