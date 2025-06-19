require 'spec_helper'
require 'basket_item'
require 'product'

describe BasketItem do
  let(:product) { Product.new(code: 'R01', name: 'Red Widget', price: '32.95') }
  let(:item) { BasketItem.new(product) }

  describe '#initialize' do
    it 'sets product and initial quantity to 0' do
      expect(item.product).to eq(product)
      expect(item.quantity).to eq(0)
    end
  end

  describe '#increment' do
    it 'increases quantity by 1' do
      expect { item.increment }.to change { item.quantity }.by(1)
    end
  end

  describe '#subtotal' do
    context 'when quantity is 0' do
      it { expect(item.subtotal).to eq(0.0) }
    end

    context 'when quantity is 2' do
      before { 2.times { item.increment } }
      it { expect(item.subtotal).to eq(65.9) }
    end
  end
end
