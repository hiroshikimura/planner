# == Schema Information
#
# Table name: lines
#
#  id           :bigint           not null, primary key
#  distance     :float            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  from_node_id :integer          not null
#  to_node_id   :integer          not null
#
# Indexes
#
#  index_lines_on_from_node_id  (from_node_id)
#  index_lines_on_to_node_id    (to_node_id)
#
require "test_helper"

class LineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
