class CreateWays < ActiveRecord::Migration[7.1]
  def change
    create_table :ways do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :robot, null: false, foreign_key: true
      t.references :node, null: false, foreign_key: true
      t.datetime :arrival_at, null: false
      t.datetime :leave_at, null: false

      t.timestamps
    end
  end
end
