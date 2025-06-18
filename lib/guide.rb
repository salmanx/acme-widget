require 'product'
require 'support/string_extend'

class Guide
  class Config
    @@actions = %w[show_products show_delivery_charge add_to_basket quit]
    def self.actions = @@actions
  end

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
    intoduction
    show_available_actions
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action(action, args)
    end

    conclusion
  end

  def get_action
    action = nil
    until Guide::Config.actions.include? action
      show_available_actions if action
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
    when action = 'add_to_basket'
      puts "\n\n<<< This action is not implemented yet >>>\n\n"
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

    show_action_header('Show all products')
    products = Product.saved_products

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

    show_product_table products
    puts("Sort using 'show_products name', 'show_products code', 'show_products by name' ")
  end

  def show_delivery_charge
    show_action_header('Show all delivery charges')
    puts "1. Delivery charge is $4.95. for orders under $50\n"
    puts "2. Delivery charge is $2.95 for orders under $90\n"
    puts "3. Delivery charge is free for orders of $90 or more\n"
    separator_line(60, 1)
  end

  def show_action_header(title)
    puts "\n#{title.upcase.center(60)}"
    separator_line(60)
  end

  def show_product_table(products)
    if products.empty?
      puts 'No products listed'
      separator_line(60, 2)
      return
    end

    show_product_table_header

    products.each do |r|
      show_product_table_body(r.code, r.name, r.price)
    end
    separator_line(60, 2)
  end

  def show_product_table_body(code, name, price)
    puts format(' %-20s %-30s %-6s', code.titleize, name.titleize, price.titleize)
  end

  def show_product_table_header
    puts format(' %-20s %-30s %-6s', 'Code', 'Name', 'Price')
    separator_line(60)
  end

  def separator_line(line_length = 60, line_break = nil)
    puts "\n" * line_break if line_break
    puts '-' * line_length
  end

  def show_available_actions
    puts "AVAILABLE ACTIONS: #{Guide::Config.actions.join(', ')} \n\n"
  end

  def intoduction
    puts "\n\n<<< Welcome to  Acme Widget Co >>> \n\n"
    puts "<<< This is an interactive guide to our new sale system >>> \n\n"
  end

  def conclusion
    puts "\n\n<<< Good Bye, Happy shopping!! >>> \n\n"
  end
end
