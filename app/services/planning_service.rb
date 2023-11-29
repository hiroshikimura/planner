# frozen_string_literal: true

class PlanningService
  attr_reader :plan

  def initialize(_params)
    @plan = Plan.with_all.find_by(job_id: @params[:id])
  end

  def call
    completed_robots = []

    while possible_robot_exists?(completed_robots) && node_exists?
      target_robot = next_robot(completed_robots)
      node = near_by(target_robot, find_of(target_robot))
      if node.present?
        # 経路作成
        travel_time = distance(robot, node) / speed
        plan.ways.create(
          arrival_at: current_time + travel_time,
          leave_at: current_time + travel_time + node.time_required,

          node: n,
          robot: target_robot
        )
      else
        # このrobotはもう動けない
        completed_robots << target_robot
      end
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

  def next_robot(completed_robots)
    plan
      .robots
      .activated(current_time)
      .where.not(id: completed_robots.pluck(:id))
      .min_by(&:latest_leave_at)
  end

  def speed
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
