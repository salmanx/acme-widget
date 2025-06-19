class DeliveryRules
  TIERS = [
    { threshold: 90,   fee: 0.00 },
    { threshold: 50,   fee: 2.95 },
    { threshold: 0,    fee: 4.95 }
  ].freeze

  def initialize
    @tiers = TIERS.sort_by { |t| -t[:threshold] } # Ensure proper order
  end

  def fee_for(subtotal)
    matching_tier = @tiers.find { |t| subtotal >= t[:threshold] }
    matching_tier[:fee]
  end
end
