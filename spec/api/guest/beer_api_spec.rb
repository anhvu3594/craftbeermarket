require 'rails_helper'

RSpec.describe 'GuestBeerApis', type: :request do
  it 'load all available beers' do
    get '/api/v1/guest_beer'

    expect(response).to have_http_status(200)
  end
end
