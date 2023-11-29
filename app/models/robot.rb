# == Schema Information
#
# Table name: robots
#
#  id         :bigint           not null, primary key
#  end_time   :datetime         not null
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

  scope :with_nodes, lambda {
    includes(:ways)
      .joins(:ways)
      .merge(Way.includes(:node).joins(:node))
  }

  scope :activated, lambda { |current_time|
    where(sanitize_sql_array([':target_time between start_time and end_time', { target_time: current_time }]))
  }

  def latest_point
    ways
      .max_by { |way| way.arrival_at + way.node.time_required }
  end

  def latest_location
    latest_point&.node&.position || position
  end

  def latest_leave_at
    latest_point.then do |w|
      w.present? ? w.arrival_at + w.node.time_required : start_time
    end
  end
end
