class CreateResults < ActiveRecord::Migration[5.1]
  def change
    create_table :results do |t|
      t.string :label
      t.float :score
      t.float :exec_time

      t.timestamps
      t.references :model, foreign_key: true
    end
  end
end
