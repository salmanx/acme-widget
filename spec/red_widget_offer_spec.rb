require 'spec_helper'
require 'red_widget_offer'
require 'basket_item'
require 'product'

describe RedWidgetOffer do
  let(:product) { Product.new(code: 'R01', name: 'Red', price: '32.95') }
  let(:item) { BasketItem.new(product) }
  let(:offer) { RedWidgetOffer.new(item) }

  describe '#apply' do
    context 'with 1 item' do
      before { item.increment }
      it 'does not apply discount' do
        expect { offer.apply }.not_to(change { item.subtotal })
      end
    end

    context 'with 2 items' do
      before { 2.times { item.increment } }
      before { offer.apply }
      it 'applies discount' do
        expect(item.subtotal).to eq(BigDecimal('49.43'))
      end
    end

    context 'with 3 items' do
      before { 3.times { item.increment } }
      before { offer.apply }

      it 'applies discount correctly' do
        expect(item.subtotal).to eq(BigDecimal('82.38')) # 2 full + 1 half
      end
    end
  end
end
