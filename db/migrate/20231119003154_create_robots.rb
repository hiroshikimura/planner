class CreateRobots < ActiveRecord::Migration[7.1]
  def change
    create_table :robots do |t|
      t.datetime :start_time, null: false
      t.string :robot_id, null: false,
      t.geometry :position, null: false, index: true

      t.timestamps
    end
  end
end
