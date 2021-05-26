require 'rails_helper'

RSpec.describe 'Merchants API' do 
  it 'gets all merchants, a maximum of 20 at a time' do 
    create_list(:merchant, 20)
    get '/api/v1/merchants'
    
    expect(response).to be_successful
    
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it 'can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to be_an(Integer)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'can get a merchants items' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(2)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end
end


