require 'csv'

class Spree::ImportService
  DEF_VALUES = {headers: true, col_sep: ';'}

  def initialize(file, arg={})
    @file = file
    @arg = arg
  end

  def call
    @required_attributes = ['name', 'shipping_category_id', 'price']
     def_values = DEF_VALUES.merge(arg)

    CSV.foreach(@file.path, def_values) do |row|
      headers = row.headers
      return unless headers_valid?(headers, @required_attributes)
      row_hash = row.to_hash
      ImportWorker.perform_async(row_hash, headers)
    end
  end

  def headers_valid?(headers, required_attributes)
    (headers & required_attributes).count == required_attributes.count
  end

  def object_valid?(product)
    product.price.present? && product.valid?
  end

  def set_attribute(obj, header, value)
    obj.send("#{header}=", value) if obj.respond_to? :"#{header}"
  end

  private

  attr_reader :arg
end

