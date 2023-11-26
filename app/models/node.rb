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
end
