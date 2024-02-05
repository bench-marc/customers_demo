# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:customer) { FactoryBot.create(:customer) }

  describe '#same_street?' do
    let(:address) { FactoryBot.create(:address, street: 'Sample Strasse', customer: customer) }

    context 'when streets are the same' do
      it 'returns true' do
        expect(address.same_street?('Sample Str.')).to be_truthy
      end
    end

    context 'when streets are different' do
      it 'returns false' do
        expect(address.same_street?('Different Strasse')).to be_falsey
      end
    end
  end
end
