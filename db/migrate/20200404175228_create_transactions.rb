class CreateTransactions < ActiveRecord::Migration[6.0]
  create_table :transactions, id: false do |t|
    t.string  :id, primary_key: true, null: false
    t.string :intent_id, null: false
    t.string :external_id, index: { unique: true }
    t.integer :value_in_cents, null: false
    t.string :currency, null: false
    t.datetime :paid_at
    t.string :status, null: false
    t.timestamps
  end
end
