class BasketItem
  attr_reader :product
  attr_accessor :quantity
  attr_writer :subtotal

  def initialize(product)
    @product = product
    @quantity = 0
    @subtotal = nil
  end

  def increment
    @quantity += 1
  end

  def subtotal
    @subtotal || (product.price.to_d * quantity)
  end
end
