class Pollgroup < ActiveRecord::Base
  has_many :profiles
  has_many :metrics
  has_many :device_types, :through => :profiles
end
