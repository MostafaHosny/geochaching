FactoryGirl.define do
  factory :in_range_location1, class: Location do
    association :message, factory: :secret_message_1
    lng 31.5005023
    lat 30.0195683
  end

  factory :in_range_location2, class: Location do
    association :message, factory: :secret_message_1
    lng 31.5005021
    lat 30.0195693
  end

  factory :out_range_location1, class: Location do
    association :message, factory: :secret_message_1
    lng 41.5005021
    lat 40.0195693
  end
  
  factory :out_range_location2, class: Location do
    association :message, factory: :secret_message_1
    lng 21.5005021
    lat 20.0195693
  end

  factory :invalid_lat_and_lng, class: Location do
    association :message, factory: :secret_message_1
    lng -321.5005021
    lat 620.0195693
  end
end
