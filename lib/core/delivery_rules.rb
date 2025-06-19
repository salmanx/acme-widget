class DeliveryRules
  TIERS = [
    { threshold: 90,   fee: 0.00 },
    { threshold: 50,   fee: 2.95 },
    { threshold: 0,    fee: 4.95 }
  ].freeze

  def initialize
    # Keep tiers sorted by threshold in descending order
    @tiers = TIERS.sort_by { |t| -t[:threshold] }
  end

  def fee_for(subtotal)
    matching_tier = @tiers.find { |t| subtotal >= t[:threshold] }
    matching_tier[:fee]
  end
end
