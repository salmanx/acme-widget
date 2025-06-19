require 'basket_item'

class Basket
  def initialize(items)
    @items = items
  end

  def add
    puts 'Adding items to basket:'
    puts @items.inspect
  end
end
