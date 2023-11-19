class CreateAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas do |t|
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
