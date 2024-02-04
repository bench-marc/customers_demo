# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :username
      t.string :firstname
      t.string :lastname
      t.date :birthdate

      t.timestamps
    end
  end
end
