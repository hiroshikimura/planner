# == Schema Information
#
# Table name: nodes
#
#  id            :bigint           not null, primary key
#  position      :geometry         not null, geometry, 0
#  time_required :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  plan_id       :bigint           not null
#
# Indexes
#
#  index_nodes_on_plan_id   (plan_id)
#  index_nodes_on_position  (position)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
class Node < ApplicationRecord
  belongs_to :plan
  has_many :from_lines, class_name: 'Line', foreign_key: 'from_node_id', dependent: :destroy
  has_many :to_lines, class_name: 'Line', foreign_key: 'to_node_id', dependent: :destroy

  scope :find_of, ->(points) do
    q = <<~EOL_SQL.squish
    EXISTS (
      SELECT 1 FROM areas
      WHERE ST_DWithin(nodes.position, areas.position, areas.radius) AND areas.id in (:area_ids)
    )
    EOL_SQL
    where(
      ActiveRecord::Base.sanitize_sql_array([q, {area_ids: points.pluck(:id)}])
    )
  end
end
