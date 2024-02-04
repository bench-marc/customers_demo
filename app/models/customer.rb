# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one :address, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthdate, presence: true

end
