class CreateJoinTableClientResults < ActiveRecord::Migration[5.1]
  def change
    create_join_table :clients, :results do |t|
       t.index [:client_id, :result_id]
       t.index [:result_id, :client_id]

       t.timestamps
    end
  end
end
