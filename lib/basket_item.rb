class BasketItem
  attr_reader :product
  attr_accessor :quantity

  def initialize(product)
    @product = product
    @quantity = 0
  end

  def increment
    @quantity += 1
  end

  def subtotal
    product.price * quantity
  end
end
