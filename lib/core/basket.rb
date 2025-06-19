# Basket
# ----------
# Encapsulates a customer's shopping basket.
# Applies special offers and calculates the final total with delivery charges

require_relative 'basket_item'
require_relative 'delivery_rules'
require_relative '../offers/red_widget_offer'

class Basket
  def initialize(items)
    @items = items
  end

  def apply_offers
    @items.each do |item|
      if item.product.code == 'R01'
        RedWidgetOffer.new(item).apply
      else
        item
      end
    end

    self
  end

  def total
    subtotal = @items.sum(&:subtotal)
    delivery_fee = DeliveryRules.new.fee_for(subtotal)
    (subtotal + delivery_fee).round(2)
  end
end
