require 'csv'

class Product
  @@filepath = nil

  attr_accessor :code, :name, :price

  def self.filepath=(path = nil)
    @@filepath = File.join(path)
  end

  def self.file_exist?
    @@filepath && File.exist?(@@filepath)
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exist?(@@filepath)
    return false unless File.readable?(@@filepath)

    true
  end

  def self.saved_products
    products = []
    if file_usable?
      CSV.foreach(@@filepath, headers: true, header_converters: :symbol, col_sep: ',') do |row|
        products << Product.new.import_line(row.to_h)
      end
    end
    products
  end

  def initialize(args = {})
    @code, @name, @price = args.values_at(:code, :name, :price)
  end

  def import_line(line)
    @code, @name, @price = line.values_at(:code, :name, :price)
    self # Ensure returns the modified object itself
  end
end
