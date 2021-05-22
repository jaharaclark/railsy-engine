require 'rails_helper'

RSpec.describe 'Merchants API' do 
  it 'gets all merchants, a maximum of 20 at a time' do 
    create_list(:merchant, 20)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end
end
