class Message < ApplicationRecord
	belongs_to :location
	validates_presence_of :content
end
