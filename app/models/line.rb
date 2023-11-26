# == Schema Information
#
# Table name: lines
#
#  id           :bigint           not null, primary key
#  distance     :integer          not null
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
class Line < ApplicationRecord
end
