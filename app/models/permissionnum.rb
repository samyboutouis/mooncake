class Permissionnum < ApplicationRecord
    belongs_to :courserequest
    belongs_to :course
end
