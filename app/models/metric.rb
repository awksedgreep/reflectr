class Metric < ActiveRecord::Base
  belongs_to :pollgroup
  belongs_to :metric_type
  belongs_to :data_type
  has_many :stats
end
