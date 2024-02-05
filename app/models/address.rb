# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :customer

  validates_presence_of :street, :housenumber, :zip, :city

  def same_street?(input_street)
    normalize_street(input_street) == normalize_street(street)
  end

  private

  def normalize_street(street)
    street.downcase.gsub(/strasse|strase|straße/i, 'str').gsub(/(\W|\d)/, '')
  end
end
