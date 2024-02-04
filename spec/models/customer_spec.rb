# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:existing_customer) { create(:customer, address: existing_address) }
  let(:existing_address) { build(:address) }

  context "when customer's details are different" do
    let(:customer) { build(:customer) }

    it 'should be valid' do
      expect(customer.valid?).to be true
    end
  end

  context 'when personal details are equal' do
    let(:customer) do
      build(:customer,
            firstname: existing_customer.firstname,
            lastname: existing_customer.lastname,
            birthdate: existing_customer.birthdate,
            address: address)
    end

    context 'when address is equal' do
      let(:address) do
        build(:address,
              street: existing_address.street,
              housenumber: existing_address.housenumber,
              zip: existing_address.zip,
              city: existing_address.city)
      end

      it 'is not valid and has errors' do
        expect(customer.valid?).to be false
      end
    end

    context 'when address is different' do
      let(:address) { build(:address) }

      it 'should be valid' do
        expect(customer.valid?).to be true
      end
    end

    context 'when only name is a little different' do
      let(:existing_customer) { create(:customer, lastname: 'Dr. Mustermann', address: existing_address) }
      let(:customer) do
        build(:customer,
              firstname: existing_customer.firstname,
              lastname: 'Mustermann',
              birthdate: existing_customer.birthdate,
              address: address)
      end
      let(:address) do
        build(:address,
              street: existing_address.street,
              housenumber: existing_address.housenumber,
              zip: existing_address.zip,
              city: existing_address.city)
      end

      it 'should not be valid' do
        expect(customer.valid?).to be false
      end
    end

    context 'when only streetname is a little different' do
      let(:existing_address) { build(:address, street: 'Schillerstraße') }
      let(:customer) do
        build(:customer,
              firstname: existing_customer.firstname,
              lastname: existing_customer.lastname,
              birthdate: existing_customer.birthdate,
              address: address)
      end
      let(:address) do
        build(:address,
              street: 'Schillerstr.',
              housenumber: existing_address.housenumber,
              zip: existing_address.zip,
              city: existing_address.city)
      end

      it 'should not be valid' do
        expect(customer.valid?).to be false
      end
    end
  end
end
