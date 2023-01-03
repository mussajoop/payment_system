class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.string :type
      t.decimal :amount
      t.integer :status, null: false, default: 0
      t.string :customer_email
      t.string :customer_phone
      t.references :merchant, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
    add_reference :transactions, :parent, foreign_key: { to_table: :transactions }, type: :uuid
  end
end
