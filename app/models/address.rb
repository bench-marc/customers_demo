# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :customer

  validates :street, presence: true
  validates :housenumber, presence: true
  validates :zip, presence: true
  validates :city, presence: true
end
