class DeviceType < ActiveRecord::Base
  has_many :devices
  has_many :profiles
  has_many :pollgroups, :through => :profiles
end
