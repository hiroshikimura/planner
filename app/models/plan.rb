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
  has_many :areas, dependent: :destroy
  has_many :nodes, dependent: :destroy
  has_many :robots, dependent: :destroy
  has_many :ways, dependent: :destroy
  has_many :lines, dependent: :destroy
end
