# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  position   :geometry         not null, geometry, 0
#  radius     :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  area_id    :string           not null
#  plan_id    :bigint           not null
#
# Indexes
#
#  index_areas_on_plan_id   (plan_id)
#  index_areas_on_position  (position)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
require "test_helper"

class AreaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
