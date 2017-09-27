class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :models do |t|
      t.string :label
      t.string :language
      t.string :summary
      t.text :description

      t.timestamps
    end
  end
end
