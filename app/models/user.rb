class User < ApplicationRecord
    has_and_belongs_to_many :courses
    has_many :courserequests
end
