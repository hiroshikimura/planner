# == Schema Information
#
# Table name: ways
#
#  id         :bigint           not null, primary key
#  arrival_at :datetime         not null
#  leave_at   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  node_id    :bigint           not null
#  plan_id    :bigint           not null
#  robot_id   :bigint           not null
#
# Indexes
#
#  index_ways_on_node_id   (node_id)
#  index_ways_on_plan_id   (plan_id)
#  index_ways_on_robot_id  (robot_id)
#
# Foreign Keys
#
#  fk_rails_...  (node_id => nodes.id)
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (robot_id => robots.id)
#
class Way < ApplicationRecord
  belongs_to :node
  belongs_to :plan
  belongs_to :robot
end
