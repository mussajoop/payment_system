# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false
      t.string :encrypted_password, null: false

      t.string :type
      t.string :name, null: false
      t.string :description
      t.integer :status, null: false, default: 0
      t.decimal :total_transaction_sum, null: false, default: 0.0

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
