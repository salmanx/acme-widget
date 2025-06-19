require 'spec_helper'
require 'basket'
require 'basket_item'
require 'product'

describe Basket do
  let(:product1) { Product.new(code: 'B01', name: 'Blue', price: '7.95') }
  let(:product2) { Product.new(code: 'R01', name: 'Red', price: '32.95') }
  let(:items) { [BasketItem.new(product1), BasketItem.new(product2)] }

  before do
    2.times { items[0].increment } # 2 Blue widgets
    3.times { items[1].increment } # 3 Red widgets
  end

  describe '#apply_offers' do
    it 'applies offers to relevant items' do
      basket = Basket.new(items)
      expect(basket.apply_offers.total).to eq(BigDecimal('98.28'))
    end
  end
end
