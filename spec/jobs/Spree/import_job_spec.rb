require 'spec_helper'

describe ImportWorker do
    let!(:valid_csv_file) {File.new(Rails.root.join('../fixtures/csv/sample1.csv'))}
    let!(:invalid_csv_file) {File.new(Rails.root.join('../fixtures/csv/sample.csv'))}

  it 'enqueue ImportWorker jobs from a file with proper attributes' do
    Spree::ShippingCategory.create!(id: 1, name: 'test_shipname')
    expect {
      Spree::Product.import(valid_csv_file)
    }.to change(ImportWorker.jobs, :size).by 3

    expect(ImportWorker.jobs.last["args"][0]["name"]).to eq 'Spree Tote'
    expect(ImportWorker.jobs.first["args"][0]["price"]).to eq '3.00'
    expect(ImportWorker.jobs[1]["args"][0]["description"]).to eq 'second product description'

    ImportWorker.drain

    assert_equal 0, ImportWorker.jobs.size
  end

  it "doesn't send jobs to ImportWorker from invalid file" do
    Spree::ShippingCategory.create!(id: 1, name: 'test_shipname')
    expect {
      Spree::Product.import(invalid_csv_file)
    }.to change(ImportWorker.jobs, :size).by 0
  end

  it 'enqueue ImportWorker job' do
    Spree::ShippingCategory.create!(id: 1, name: 'test_shipname')
    row_hash = {"name"=>"Test Bag", "description"=>"test desc", "shipping_category_id"=>"1", "price"=>"9.99"}
    headers = ["name", "description", "shipping_category_id", "price"]
    expect {
      ImportWorker.perform_async(row_hash, headers)
    }.to change(ImportWorker.jobs, :size).by 1

    expect(ImportWorker.jobs.first["args"][0]["name"]).to eq 'Test Bag'
    expect(ImportWorker.jobs.first["args"][0]["price"]).to eq '9.99'
    expect(ImportWorker.jobs.first["args"][0]["description"]).to eq 'test desc'
    expect(ImportWorker.jobs.first["args"][0]["shipping_category_id"]).to eq '1'

    ImportWorker.drain

    assert_equal 0, ImportWorker.jobs.size

  end    
end
