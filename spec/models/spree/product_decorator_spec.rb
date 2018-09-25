require 'spec_helper'

describe Spree::Product, type: :model do
  describe ".import" do

    # let!(:) {create :shipping_catego(name: "testname", shopping_category_id}
    let!(:valid_csv_file) {File.new(Rails.root.join('../fixtures/csv/sample1.csv'))}
    let!(:invalid_csv_file) {File.new(Rails.root.join('../fixtures/csv/sample.csv'))}

    it "import csv file with valid data" do
      Spree::ShippingCategory.create!(id: 1, name: 'test_shipname')
      products = Spree::Product.all

      described_class.import(valid_csv_file)

      expect(products.count).to eq 3
      expect(products.last.name).to eq 'Spree Tote'
      expect(products.first.price).to eq 3.00
      expect(products[1].description).to eq 'second product description'
    end

    it "doesn't save invalid data" do
      Spree::ShippingCategory.create!(id: 1, name: 'test_shipname')
      products = Spree::Product.all

      described_class.import(invalid_csv_file)

      expect(products.count).to eq 0
    end
  end
end