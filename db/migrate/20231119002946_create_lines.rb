class CreateLines < ActiveRecord::Migration[7.1]
  def change
    create_table :lines do |t|
      t.integer :from_node_id, null: false, index: true
      t.integer :to_node_id, null: false, index: true
      t.integer :distance, null: false

      t.timestamps
    end
  end
end
