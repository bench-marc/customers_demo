# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one :address, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthdate, presence: true
  validate :unique_details_and_address_combination, on: :create

  accepts_nested_attributes_for :address

  def unique_details_and_address_combination
    existing_customer = find_existing_customer_with_similar_details

    return unless existing_customer
    return unless existing_customer.address.same_street?(address.street)

    errors.add(:base, "Details are same as for Customer #{existing_customer.id}")
  end

  private

  def find_existing_customer_with_similar_details
    similarity_threshold = 0.7

    Customer
      .joins(:address)
      .where('SIMILARITY(firstname, :firstname) > :threshold AND SIMILARITY(lastname, :lastname) > :threshold', firstname: firstname, lastname: lastname, threshold: similarity_threshold)
      .where(birthdate: birthdate)
      .where('addresses.zip': address.zip, 'addresses.city': address.city)
      .first
  end
end
