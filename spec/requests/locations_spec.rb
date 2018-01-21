require 'rails_helper'

describe 'Location'  , :type => :request do
  context 'create' do
    it 'creates a message with location successfully' do
      @params = { location: attributes_for(:in_range_location1).
      merge(message_attributes: attributes_for(:secret_message_1))}
      post("/api/v1/locations/", params: @params)
      body =  JSON.load(@response.body)
      loc = Location.last
      
      expect(response).to be_created
      expect(loc.lat).to eq body['lat']
      expect(loc.lng).to eq body['lng']
      expect(loc.message.content).to eq body['message']['content']
    end

    it 'it prevent adding location with invalid params' do 
      @params = { location: attributes_for(:invalid_lat_and_lng)}
      post("/api/v1/locations/", params: @params)
      body =  JSON.load(@response.body) 
      expect(response).to be_bad_request
      expect(body['message'].first).to eq "can't be blank"
      expect(body['lat'].first).to eq "must be less than or equal to 90"
      expect(body['lng'].first).to eq "must be greater than or equal to -180"
    end
  end

  context 'Get Locations' do
    before :each do
      @in_range1 = create(:in_range_location1)
      @in_range2 = create(:in_range_location2)
      @out_range1 = create(:out_range_location1)
      @out_range2 = create(:out_range_location2)
      @params = { lat: @in_range1.lat + 0.01 , lng: @in_range1.lng + 0.01}
      get('/api/v1/locations/nearby',params: @params)
    end
    
    it 'it get all location in range 100 kms' do
      body =  JSON.load(@response.body)
      expect(response).to be_ok
      expect(body.count).to eq 2
      expect(body.first['id']).to eq(@in_range1.id)
      expect(body.second['id']).to eq(@in_range2.id)
    end

    it 'exclude all location out range 100 km' do
      body =  JSON.load(@response.body)
      expect(response).to be_ok
      expect(body.count).to eq 2
      expect(body.map{|a| a['id']}).not_to include(@out_range1.id)
      expect(body.map{|a| a['id']}).not_to include(@out_range2.id)
    end
  end

  context 'Get Closest Location' do 
    it 'it should get the closest location' do
      @in_range1 = create(:in_range_location1)
      @params = { lat: @in_range1.lat + 0.01 , lng: @in_range1.lng + 0.01}
      get('/api/v1/locations/closest',params: @params)
      body =  JSON.load(@response.body)
      expect(response).to be_ok
      expect(body['lat']).to eq(@in_range1.lat)
      expect(body['lng']).to eq(@in_range1.lng)
      expect(body['message']['content']).to eq(@in_range1.message.content)
    end

    it 'retun all location out range 100 km' do
      get('/api/v1/locations/closest')
      body =  JSON.load(@response.body)
      expect(response).to be_bad_request
      expect(body['error']).to eq 'Please enter a valid location'
    end
  end
end