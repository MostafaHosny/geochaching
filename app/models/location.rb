class Location < ApplicationRecord
  acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :lng


  has_one :message

  validates_presence_of  :lat , :lng
  validates_uniqueness_of :lat , :lng
  validates :lat , numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  
  accepts_nested_attributes_for :message
  
  def self.nearby(lat , lng)
    byebug
    Location.within(100, :origin => [lat ,lng])
  end

  def self.closest(lat , lng)
    Location.by_distance(origin: [lat,lng]).limit(1)
  end

end
