require 'support/string_extend'

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
    puts("Sort using 'show_products name', 'show_products code', 'show_products by name' ")
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
end
