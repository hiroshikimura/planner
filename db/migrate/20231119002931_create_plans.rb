class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.datetime :planned_at, null: false
      t.text :planning_info, null: false
      t.string :plan_id, null: false
      
      t.timestamps
    end
  end
end
