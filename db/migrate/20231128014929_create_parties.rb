class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.integer :duration
      t.string :date
      t.string :start_time
      t.integer :movie_id

      t.timestamps
    end
  end
end
