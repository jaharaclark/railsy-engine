require 'rails_helper'

RSpec.describe 'Items API' do 
  it 'gets all items, a maximum of 20 at a time' do
    create_list(:item, 20)
    
    get '/api/v1/items'
    
    expect(response).to be_successful
    
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(20)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)
      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)
      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)
      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  end

  it 'can get one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful 

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(Integer)
    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)
    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)
    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)
    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to be_an(Integer)
  end

  it 'can create a new item' do
    merchant = create(:merchant)
    item_params = ({
                    name: 'Sticky Note',
                    description: 'a place to write thoughts',
                    unit_price: 3.98,
                    merchant_id: merchant.id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}
    
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    created_item = Item.last
    
    expect(response).to be_successful
    expect(created_item[:name]).to eq(item_params[:name])
  end
end