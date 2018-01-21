class Location < ApplicationRecord
  
  acts_as_mappable :lat_column_name => :lat,
                   :lng_column_name => :lng
  #------------------------------ Associations --------------------------------
  has_one :message
  #------------------------------- Validations --------------------------------
  validates_presence_of  :message, :lat, :lng
  validates_uniqueness_of :lat, :lng
  validates :lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90}
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180}
  
  accepts_nested_attributes_for :message
  #--------------------------------- Methods ----------------------------------
  def self.nearby(lat , lng)
    Location.within(100, :origin => [lat,lng])
  end
 # check the distance between origin and all other points and order them asc then get
 #the nearest one  
  def self.closest(lat , lng)
    Location.by_distance(origin: [lat,lng]).first
  end

end
