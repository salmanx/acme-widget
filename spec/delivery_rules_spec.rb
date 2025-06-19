require 'spec_helper'
require 'delivery_rules'

describe DeliveryRules do
  let(:rules) { DeliveryRules.new }

  describe '#fee_for' do
    context 'when subtotal is $90' do
      it { expect(rules.fee_for(90)).to eq(0.0) }
    end

    context 'when subtotal is $50' do
      it { expect(rules.fee_for(50)).to eq(2.95) }
    end

    context 'when subtotal is $30' do
      it { expect(rules.fee_for(30)).to eq(4.95) }
    end
  end
end
