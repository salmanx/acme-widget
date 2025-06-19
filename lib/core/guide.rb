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

  def get_action
    action = nil
    until Config.actions.include? action
      Render.show_available_actions
      print '> '
      user_response = gets.chomp
      args = user_response.downcase.strip.split(' ')
      action = args.shift
    end

    [action, args]
  end

  def do_action(action, args = [])
    case action
    when action = 'show_products'
      show_products(args)
    when action = 'add'
      add_to_basket
    when action = 'show_delivery_charge'
      show_delivery_charge
    when action = 'quit'
      :quit
    else
      puts "\nPlease use only allowed commands!\n"
    end
  end

  def show_products(args)
    sort_order = args.shift
    sort_order = args.shift if sort_order == 'by'
    sort_order = 'code' unless %w[code name price].include?(sort_order)

    Render.show_action_header('Show all products')

    products = Product.saved_products

    if products.empty?
      puts 'No products Found'
      Render.separator_line(60, 2)
      return
    end

    products.sort! do |r1, r2|
      case sort_order
      when 'code'
        r1.code.downcase <=> r2.code.downcase
      when 'name'
        r1.name.downcase <=> r2.name.downcase
      when 'price'
        r1.price.to_i <=> r2.price.to_i
      end
    end

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
        puts "\nProduct #{code} not found\n"
      end
    end

    return unless baskets.any?

    total = Basket.new(baskets).add.total.to_s('F')
    Render.show_basket_table(baskets, total)
  end

  def show_delivery_charge
    Render.show_delivery_charge_rules
  end
end
