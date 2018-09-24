require 'csv'

Spree::Product.class_eval  do
  def self.import(file)
    headers = CSV.read(file.path, headers: true, col_sep: ';').headers
    CSV.foreach(file.path, headers: true,  col_sep: ';') do |row|
      product_hash = row.to_hash
      product = Spree::Product.new
      headers.each do |header|
        product.send("#{header}=", product_hash["#{header}"]) if product.respond_to? :"#{header}"
      end
      product.save
    end
  end
end
