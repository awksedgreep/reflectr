require 'test_helper'

class DataTypeTest < ActiveSupport::TestCase
  fixtures :all
  
  test "data_type -> metric relationship" do
    assert counter = DataType.where(:name => 'Counter').first
    assert_kind_of DataType, counter
    assert_not_nil counter
    assert counter_metrics = counter.metrics
    assert_kind_of Array, counter_metrics
    assert_not_nil counter_metrics
    assert_kind_of Metric, counter_metrics.first
    assert_not_nil counter_metrics.first
  end
  
  test "data_type crud" do
    assert boogie = DataType.create(:name => 'Boogie')
    assert_kind_of DataType, boogie
    assert_not_nil boogie
    assert_not_nil boogie.id
    assert_kind_of ActiveSupport::TimeWithZone, boogie.created_at
    assert_not_nil boogie.created_at
    assert_kind_of ActiveSupport::TimeWithZone, boogie.updated_at
    assert_not_nil boogie.updated_at
    assert_kind_of Integer, boogie.id
    assert_not_nil boogie.id
    assert boogie_id = boogie.id # for later
    assert boogie.name = 'Woogie'
    assert boogie.save
    assert find_woogie = DataType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie.first
    assert_kind_of DataType, find_woogie.first
    assert woogie = find_woogie.first
    assert boogie_id = woogie.id
    assert woogie.destroy
    assert find_woogie = DataType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie
    assert_nil find_woogie.first
  end
end
