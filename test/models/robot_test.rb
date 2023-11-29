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
require "test_helper"

class RobotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
