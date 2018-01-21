class Message < ApplicationRecord
	validates_presence_of :content
	validates_format_of :content,
                      with: /[a-zA-Z\d\s]*/, allow_blank: true
  validates_length_of :content, :minimum => 2, :maximum => 300
end
