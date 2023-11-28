# == Schema Information
#
# Table name: robots
#
#  id         :bigint           not null, primary key
#  position   :geometry         not null, geometry, 0
#  start_time :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#  robot_id   :string           not null
#
# Indexes
#
#  index_robots_on_plan_id   (plan_id)
#  index_robots_on_position  (position)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
class Robot < ApplicationRecord
  has_many :ways, dependent: :destroy
  has_many :plans, through: :ways
  has_many :nodes, through: :ways
  has_many :lines, through: :nodes
  has_many :area_robots, dependent: :destroy
  has_many :areas, through: :area_robots

  validates :robot_id, presence: true, uniqueness: true
  validates :start_time, presence: true
  validates :position, presence: true

  scope :in_area, ->(area) { where(id: area.robots) }
  scope :in_plan, ->(plan) { where(id: plan.robots) }
  scope :in_node, ->(node) { where(id: node.robots) }
  scope :in_way, ->(way) { where(id: way.robots) }
  scope :in_line, ->(line) { where(id: line.robots) }
  scope :in_time, ->(time) { where(start_time: time) }
  scope :in_position, ->(position) { where(position: position) }
  scope :in_plan_at, ->(plan, time) { in_plan(plan).in_time(time) }
  scope :in_node_at, ->(node, time) { in_node(node).in_time(time) }
  scope :in_way_at, ->(way, time) { in_way(way).in_time(time) }
  scope :in_line_at, ->(line, time) { in_line(line).in_time(time) }
  scope :in_area_at, ->(area, time) { in_area(area).in_time(time) }
  scope :in_plan_at_node, ->(plan, node, time) { in_plan_at(plan, time).in_node_at(node, time) }
  scope :in_plan_at_way, ->(plan, way, time) { in_plan_at(plan, time).in_way_at(way, time) }
  scope :in_plan_at_line, ->(plan, line, time) { in_plan_at(plan, time).in_line_at(line, time) }
  scope :in_plan_at_area, ->(plan, area, time) { in_plan_at(plan, time).in_area_at(area, time) }
  scope :in_node_at_plan, ->(node, plan, time) { in_node_at(node, time).in_plan_at(plan, time) }
end
