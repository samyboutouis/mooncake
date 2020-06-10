class Course < ApplicationRecord
    has_and_belongs_to_many :user
    has_and_belongs_to_many :prereq
    has_many :courserequest
    has_many :permissionnum
end
