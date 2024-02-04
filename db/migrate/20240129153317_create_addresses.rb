# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :housenumber
      t.string :zip
      t.string :city
      t.belongs_to :customer, foreign_key: true

      t.timestamps
    end
  end
end
