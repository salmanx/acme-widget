require_relative 'product'
require_relative 'basket_item'
require_relative 'basket'
require_relative 'config'
require_relative '../helpers/render'

class Guide
  def initialize(filepath = nil)
    Product.filepath = filepath

    if Product.file_exist?
      puts 'Found the product csv file'
    else
      puts "\n\n<<< No csv file found for products. Exiting.. >>>"
      exit!
    end
  end

  def launch!
    Render.introduction

    result = nil
    until result == :quit
      action, args = get_action

      result = do_action(action, args)
    end

    Render.conclusion
  end

  private

  def get_action
    action = nil
    args = []

    loop do
      Render.show_available_actions
      print '> '
      user_response = gets.chomp.strip
      next if user_response.empty?

      args = user_response.split(' ')
      input = args.shift

      action = Config.valid_action?(input)
      break if action # Exit loop if valid action found

      Config.show_actions_details
    end

    [action, args]
  end

  def do_action(action, args = [])
    case action
    when action = 'list'
      show_products(args)
    when action = 'add'
      add_to_basket
    when action = 'rules'
      show_delivery_charge
    when action = 'quit'
      :quit
    else
      Config.show_actions_details
    end
  end

  def show_products(sort_order)
    Render.show_action_header('Show all products')

    products = Product.saved_products

    if products.empty?
      puts 'No products Found'
      Render.separator_line(60, 2)
      return
    end

    sort_products(products, sort_order)

    Render.show_product_table products

    Render.show_sort_action_title
  end

  def add_to_basket
    Render.show_action_header('Add products to basket')
    Render.show_basket_action_title

    user_response = gets.chomp
    product_codes = user_response.split(',').map(&:strip).reject(&:empty?)

    if product_codes.empty?
      puts 'No products added to basket'
      Render.separator_line(60, 2)
      return
    end

    products = Product.saved_products

    baskets = build_basket(product_codes, products)

    return unless baskets.any?

    total = Basket.new(baskets).apply_offers.total.to_s('F')
    Render.show_basket_table(baskets, total)
  end

  def show_delivery_charge
    Render.show_delivery_charge_rules
  end

  def sort_products(products, sort_order)
    order = sort_order.shift
    order = sort_order.shift if order == 'by'
    order = 'code' unless %w[code name price].include?(order)

    products.sort! do |r1, r2|
      case order
      when 'code'
        r2.code.downcase <=> r1.code.downcase # Descending order
      when 'name'
        r1.name.downcase <=> r2.name.downcase
      when 'price'
        r1.price.to_i <=> r2.price.to_i
      end
    end
  end

  def build_basket(product_codes, products)
    baskets = []

    # Pre-index products by lowercase code for O(1) lookups
    products_by_code = products.each_with_object({}) do |product, hash|
      hash[product.code.downcase] = product
    end

    product_codes.each do |code|
      product = products_by_code[code.downcase]

      if product
        basket_item = baskets.find do |item|
          item.product.code.downcase == code.downcase
        end || baskets.push(BasketItem.new(product)).last
        basket_item.increment
      else
        puts "\nERROR: Product #{code} not found\n"
      end
    end

    baskets
  end
end
