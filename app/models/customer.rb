# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one :address, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthdate, presence: true
  validate :details_address_combination_is_unique, on: :create

  accepts_nested_attributes_for :address

  def details_address_combination_is_unique
    existing_customer = Customer
                        .joins(:address)
                        .where('SIMILARITY(firstname, :firstname) > 0.7 AND SIMILARITY(lastname, :lastname) > 0.7', firstname: firstname, lastname: lastname)
                        .where(birthdate: birthdate)
                        .where('SIMILARITY(addresses.street, :street) > 0.5', street: address.street)
                        .where('addresses.housenumber': address.housenumber, 'addresses.zip': address.zip, 'addresses.city': address.city)
                        .first

    errors.add(:base, "Details are same as for Customer #{existing_customer.id}") if existing_customer
  end
end
