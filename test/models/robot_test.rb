# == Schema Information
#
# Table name: robots
#
#  id         :bigint           not null, primary key
#  position   :geometry         not null, geometry, 0
#  start_time :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  robot_id   :string           not null
#
# Indexes
#
#  index_robots_on_position  (position)
#
require "test_helper"

class RobotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
