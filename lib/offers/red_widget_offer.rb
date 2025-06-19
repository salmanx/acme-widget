# This class defines a specific offer for red widgets (R01).
module Offers
  class RedWidgetOffer
    def apply(items)
      item = items['R01']
      return 0 unless item && item.quantity > 1

      eligible_pairs = item.quantity / 2
      discount = eligible_pairs * (item.product.price / 2)
      -discount.round(2)
    end
  end
end
