require 'csv'
require_relative './helper'

Spree::Product.class_eval  do

  def self.import(file)
    required_attributes = ['name', 'shipping_category_id', 'price']

    CSV.foreach(file.path, headers: true, col_sep: ';') do |row|
      headers = row.headers
      return unless headers_valid?(headers, required_attributes)
      product = Spree::Product.new
      headers.each do |header|
        product.set_attribute(product, header, row["#{header}"]) 
      end
      product.save if product.product_valid?(product)
    end
  end

  def self.headers_valid?(headers, required_attributes)
    (headers & required_attributes).count == 3
  end

  def product_valid?(product)
    if product.price != nil
      product.valid?
    else
      false
    end
  end

  def set_attribute(obj,header, value)
    obj.send("#{header}=", value) if obj.respond_to? :"#{header}"
  end
end
