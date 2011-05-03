class Stat < ActiveRecord::Base
  belongs_to :device
  belongs_to :metric
end
