require 'rails_helper'

RSpec.describe Location, type: :model do
  

  context 'Validations' do
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_presence_of(:message) }
    it { expect(create(:in_range_location1)).to be_valid }
    it { expect(build(:invalid_lat_and_lng)).not_to be_valid }
  end
end
