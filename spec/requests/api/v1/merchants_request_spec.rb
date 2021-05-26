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
end


