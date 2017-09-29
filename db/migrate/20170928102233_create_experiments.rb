class CreateExperiments < ActiveRecord::Migration[5.1]
  def change
    create_table :experiments do |t|
      t.text :text
      t.timestamps
    end

    add_reference :experiments, :client, foreign_key: true
    add_reference :results, :experiment, foreign_key: true
  end
end
