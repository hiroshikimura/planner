# == Schema Information
#
# Table name: plans
#
#  id            :bigint           not null, primary key
#  planned_at    :datetime         not null
#  planning_info :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  plan_id       :string           not null
#
class Plan < ApplicationRecord
end
