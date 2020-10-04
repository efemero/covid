class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.datetime :date
      t.string :province
      t.string :region
      t.integer :test_total
      t.integer :test_pos

      t.timestamps
    end
  end
end
