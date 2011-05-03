class Profile < ActiveRecord::Base
  belongs_to :device_type
  belongs_to :pollgroup
end
