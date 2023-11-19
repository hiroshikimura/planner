class CreateAreaRobots < ActiveRecord::Migration[7.1]
  def change
    create_table :area_robots do |t|
      t.references :robot, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
