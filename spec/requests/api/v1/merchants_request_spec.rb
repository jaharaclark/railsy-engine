require 'rails_helper'

RSpec.describe 'Merchants API' do 
  before :each do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
  end
  
  #Get All Merchants
  it 'happy: gets all merchants, a maximum of 20 at a time' do 
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

  it 'happy: gets all merchants, 50 per page' do 
    create_list(:merchant, 50)
    get '/api/v1/merchants?per_page=50&page=1'
    
    expect(response).to be_successful
    
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants.count).to eq(50)
  end

  it 'sad: fetching page 1 if page is 0 or lower' do
    create_list(:merchant, 20)
    get '/api/v1/merchants?per_page=20&page=-2'
    expect(response).to be_successful
    
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants.count).to eq(20)

    get '/api/v1/merchants?per_page=20&page=0'
    expect(response).to be_successful
    
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants.count).to eq(20)
  end
  
  #Get One Merchant
  it 'happy: can get one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful
    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to be_an(Integer)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'sad: bad merchant integer id returns 404' do
    get "/api/v1/merchants/863516878328343843"
    expect(response).not_to be_successful
    expect(response.status).to eq(404)
  end

  #Get A Merchant's Items
  it 'can get a merchants items' do
    get "/api/v1/merchants/#{@merchant.id}/items"

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

  it 'sad: bad merchant integer id returns 404 and no items' do
    get "/api/v1/merchants/8293478202384935/items"
    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).not_to be_successful
    expect(response.status).to eq(404)
    expect(items).to eq(nil)
  end
end


