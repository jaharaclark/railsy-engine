require 'rails_helper'

RSpec.describe 'Items API' do 
  before :each do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    create_list(:item, 80)
  end

  #Get All Items
  it 'happy: gets all items, a maximum of 20 at a time' do
    get '/api/v1/items'
    
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items.count).to eq(20)

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

  it 'happy: fetches second page of 20 items' do
    get '/api/v1/items?per_page=20&page=2'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items.count).to eq(20)      
  end
  
  it 'sad: fetching page 1 if page is 0 or lower' do
    get '/api/v1/items?per_page=20&page=0'
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items.count).to eq(20)

    get '/api/v1/items?per_page=20&page=-7'
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(items.count).to eq(20)
  end
  
#Get One Item
  it 'happy: can get one item by its id' do
    get "/api/v1/items/#{@item_1.id}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful 

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

  it 'sad: bad item integer id returns 404' do
    get "/api/v1/items/1364648843"
    expect(response).not_to be_successful
    expect(response.status).to eq(404)
  end

  #Create (then Delete) One Item
  it 'happy: can create a new item' do
    item_params = ({
                    name: 'Sticky Note',
                    description: 'a place to write thoughts',
                    unit_price: 3.98,
                    merchant_id: @merchant_1.id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    created_item = Item.last
    
    expect(response).to be_successful
    expect(created_item[:name]).to eq(item_params[:name])
  end

  #Update One Item
  it 'edge: string item id returns 404' do
    item_id_string = "3515"
    get "/api/v1/items/#{item_id_string}"
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).not_to be_successful
    expect(response.status).to eq(404)
    expect(item).to eq(nil)
  end

  #Get an Item's Merchant
  it 'happy: can get an items merchant' do
    get "/api/v1/items/#{@item_1.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(merchant[:id].to_i).to eq(@merchant_1.id)
  end

    it 'sad: bad merchant integer id returns 404 and no items' do
    get "/api/v1/items/16843187516853"
    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).not_to be_successful
    expect(response.status).to eq(404)
    expect(item).to eq(nil)
  end

end