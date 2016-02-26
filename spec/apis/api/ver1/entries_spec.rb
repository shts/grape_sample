require 'rails_helper'

RSpec.describe API::Ver1::Entries, type: :request do
  describe 'GET /api/v1/entries' do
    
    it 'responds successfully' do
      #FactoryGirl.create_list(:entry, 30)
      get '/api/v1/entries'
      expect(response).to be_success
      #expect(response.status).to eq(200)
    end
    
  end
end