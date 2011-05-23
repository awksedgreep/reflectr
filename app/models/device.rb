class Device < ActiveRecord::Base
  belongs_to :device_type
  has_many :stats
  has_many :current_stats
end
