require 'spec_helper'
require 'product'

describe Product do
  let(:product) { Product.new(code: 'B01', name: 'Blue Widget', price: '7.95') }

  describe '#initialize' do
    it 'sets code, name and price' do
      expect(product.code).to eq('B01')
      expect(product.name).to eq('Blue Widget')
      expect(product.price).to eq('7.95')
    end
  end

  describe '.saved_products' do
    before do
      Product.filepath = 'spec/fixtures/products.csv'
    end

    it 'returns array of product objects' do
      products = Product.saved_products
      expect(products.size).to eq(3)
      expect(products.first).to be_a(Product)
    end
  end

  describe '.file_exist?' do
    context 'when file exists' do
      before { Product.filepath = 'spec/fixtures/products.csv' }
      it { expect(Product.file_exist?).to be true }
    end

    context 'when file does not exist' do
      before { Product.filepath = 'nonexistent.csv' }
      it { expect(Product.file_exist?).to be false }
    end
  end
end
