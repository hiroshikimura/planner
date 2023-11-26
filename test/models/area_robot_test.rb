# == Schema Information
#
# Table name: area_robots
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  area_id    :bigint           not null
#  robot_id   :bigint           not null
#
# Indexes
#
#  index_area_robots_on_area_id   (area_id)
#  index_area_robots_on_robot_id  (robot_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#  fk_rails_...  (robot_id => robots.id)
#
require "test_helper"

class AreaRobotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
