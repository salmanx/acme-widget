class Config
  @actions = %w[show_products show_delivery_charge add quit]
  class << self
    attr_reader :actions
  end
end
