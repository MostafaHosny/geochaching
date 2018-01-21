require 'rails_helper'

RSpec.describe Location, type: :model do
  

  context 'Validations' do
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:message) }
    it { expect(create(:in_range_location1)).to be_valid }
    it { expect(build(:invalid_lat_and_lng)).not_to be_valid }
  end

  context 'Methods' do 
    before :each do
      @in_range1 = create(:in_range_location1)
      @in_range2 = create(:in_range_location2)
      @out_range1 = create(:out_range_location1)
      @out_range2 = create(:out_range_location2)
    end
    it "should return all nearbys location within 100 kms" do 
      locations = Location.nearby(@in_range1.lat , @in_range1.lng)
      expect(locations.count).to eq 2
    end

    it "should not return all nearbys location outside 100 kms" do 
      locations = Location.nearby(@in_range1.lat, @in_range1.lng)
      expect(locations.map(&:id)).not_to include([@out_range1.id, @out_range2.id ])
    end

    it "should return the closest location" do 
      location = Location.closest(@in_range1.lat , @in_range1.lng )
      expect(location.id).to eq(@in_range1.id)
      expect(location.lat).to eq(@in_range1.lat)
      expect(location.lng).to eq(@in_range1.lng)
    end
  end
end
