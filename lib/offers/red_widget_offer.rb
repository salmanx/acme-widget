class RedWidgetOffer
  def initialize(item)
    @item = item
  end

  def apply
    quantity = @item.quantity.to_i
    return @item if quantity < 2 # No discount for single item

    price = @item.product.price.to_d
    full_price_items = (quantity + 1) / 2
    half_price_items = quantity / 2

    subtotal = (full_price_items * price) + (half_price_items * price * 0.5)
    @item.subtotal = subtotal.round(2)
    self
  end
end
