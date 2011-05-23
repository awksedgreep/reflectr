require 'test_helper'

class PollgroupTest < ActiveSupport::TestCase
  fixtures :all
  
  test "pollgroup -> profile relationship" do
    assert hornetq = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_kind_of Pollgroup, hornetq
    assert_not_nil hornetq
    assert hornetq_profiles = hornetq.profiles
    assert_kind_of Array, hornetq_profiles
    assert_not_nil hornetq_profiles
    assert_kind_of Profile, hornetq_profiles.first
    assert_not_nil hornetq_profiles.first
    assert hornetq_profiles.first.device_type.name == 'HornetQ Server'
  end
  
  test "pollgroup -> metric relationship" do
    assert hornetq = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_kind_of Pollgroup, hornetq
    assert_not_nil hornetq
    assert hornetq_metrics = hornetq.metrics
    assert_kind_of Array, hornetq_metrics
    assert_not_nil hornetq_metrics
    assert_kind_of Metric, hornetq_metrics.first
    assert_not_nil hornetq_metrics.first
    assert hornetq_metrics.first.name == 'Messages Added'
  end
  
  test "pollgroup crud" do
    assert boogie = Pollgroup.create(:name => 'Boogie')
    assert_kind_of Pollgroup, boogie
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
    assert find_woogie = Pollgroup.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie.first
    assert_kind_of Pollgroup, find_woogie.first
    assert woogie = find_woogie.first
    assert boogie_id = woogie.id
    assert woogie.destroy
    assert find_woogie = Pollgroup.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie
    assert_nil find_woogie.first
  end
end
