require 'helpers/string_extend'
require_relative '../core/config'

module Render
  module_function

  def introduction
    puts "\n\n<<< Welcome to  Acme Widget Co >>> \n\n"
    puts "<<< This is an interactive guide to our new sale system >>> \n\n"
  end

  def conclusion
    puts "\n\n<<< Good Bye, Happy shopping!! >>> \n\n"
  end

  def separator_line(line_length = 60, line_break = nil)
    puts "\n" * line_break if line_break
    puts '-' * line_length
  end

  def show_action_header(title)
    puts "\n#{title.upcase.center(60)}"
    separator_line(60)
  end

  def show_basket_action_title
    puts "To add a product, write product_code, use comma for multiple products\n"
    puts "Example: 'R01, G01, B01'\n\n"

    print '> '
  end

  def show_sort_action_title
    puts("Sort using 'list name', 'list code', 'list by price' ")
    puts "\n"
  end

  def show_product_table_header
    puts format(' %-30s %-20s %-6s', 'Product', 'Code', 'Price')
    separator_line(60)
  end

  def show_product_table_body(code, name, price)
    puts format(' %-30s %-20s %-6s', name.titleize, code.titleize, format('$%.2f', price))
  end

  def show_product_table(products)
    show_product_table_header

    products.each do |r|
      show_product_table_body(r.code, r.name, r.price)
    end

    separator_line(60, 2)
  end

  def show_delivery_charge_rules
    show_action_header('Show all delivery charges')
    puts "1. Delivery charge is $4.95. for orders under $50\n"
    puts "2. Delivery charge is $2.95 for orders under $90\n"
    puts "3. Delivery charge is free for orders of $90 or more\n"
    separator_line(60, 1)
  end

  def show_available_actions
    action_display = Config.actions.map do |full, short|
      "#{full}(#{short})"
    end.join(', ')

    puts "AVAILABLE ACTIONS: #{action_display}\n\n"
  end

  def show_basket_table(baskets, total)
    show_action_header('Show all products in basket')
    show_basket_table_header
    codes = expanded_product_codes(baskets)
    show_basket_table_body(codes, total)
    separator_line(60, 2)
  end

  def show_basket_table_body(codes, price)
    puts format(' %-40s %-20s', codes.join(','), format('$%.2f', price))
  end

  def show_basket_table_header
    puts format(' %-40s %-20s', 'Product Code', 'Total Price')
    separator_line(60)
  end

  def expanded_product_codes(baskets)
    baskets.flat_map do |item|
      Array.new(item.quantity, item.product.code)
    end
  end
end
