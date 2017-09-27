class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string  :name
      t.boolean :active
      t.string  :token

      t.timestamps
    end
  end
end
