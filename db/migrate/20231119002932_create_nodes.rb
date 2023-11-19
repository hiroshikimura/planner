class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :nodes do |t|
      t.references :plan, null: false, foreign_key: true
      t.geometry :position, null: false, index: true
      t.integer :time_required, null: false

      t.timestamps
    end
  end
end
