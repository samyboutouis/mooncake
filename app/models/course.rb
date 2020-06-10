class Course < ApplicationRecord
    has_and_belongs_to_many :users
    has_and_belongs_to_many :prereqs
    has_many :courserequests
    has_many :permissionnums
end
