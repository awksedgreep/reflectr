require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  fixtures :all
  
  test "device_type -> profile -> pollgroup relationship" do
    assert hornetq = DeviceType.where(:name => 'HornetQ Server').first
    assert_kind_of DeviceType, hornetq
    assert_not_nil hornetq
    assert hornetq_profiles = hornetq.profiles
    assert_kind_of Array, hornetq_profiles
    assert_not_nil hornetq_profiles
    assert_kind_of Profile, hornetq_profiles.first
    assert_not_nil hornetq_profiles.first
    assert hornetq_profiles.first.pollgroup.name == 'HornetQ JMX Metrics'
  end
  
  test "pollgroup -> profile -> device_type relationship" do
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
  
  test "pollgroup -> device_type relationship(through)" do
    assert hornetq = Pollgroup.where(:name => 'HornetQ JMX Metrics').first
    assert_kind_of Pollgroup, hornetq
    assert_not_nil hornetq
    assert hornetq_device_types = hornetq.device_types
    assert_kind_of Array, hornetq_device_types
    assert_not_nil hornetq_device_types
    assert_kind_of DeviceType, hornetq_device_types.first
    assert_not_nil hornetq_device_types.first
    assert hornetq_device_types.first.name == 'HornetQ Server'
  end
  
  test "device_type -> pollgroup relationship(through)" do
    assert hornetq = DeviceType.where(:name => 'HornetQ Server').first
    assert_kind_of DeviceType, hornetq
    assert_not_nil hornetq
    assert hornetq_pollgroups = hornetq.pollgroups
    assert_kind_of Array, hornetq_pollgroups
    assert_not_nil hornetq_pollgroups
    assert_kind_of Pollgroup, hornetq_pollgroups.first
    assert_not_nil hornetq_pollgroups.first
    assert hornetq_pollgroups.first.name == 'HornetQ JMX Metrics'
  end
  
  test "device_type crud" do
    assert boogie_dt = DeviceType.create(:name => 'Boogie DT')
    assert boogie_pg = Pollgroup.create(:name => 'Boogie PG')
    assert boogie_dt.pollgroups << boogie_pg
    assert boogie_dt.pollgroups.first.name == 'Boogie PG'
    assert_kind_of DeviceType, boogie_dt
    assert_not_nil boogie_dt
    assert_not_nil boogie_dt.id
    assert_kind_of ActiveSupport::TimeWithZone, boogie_dt.created_at
    assert_not_nil boogie_dt.created_at
    assert_kind_of ActiveSupport::TimeWithZone, boogie_dt.updated_at
    assert_not_nil boogie_dt.updated_at
    assert_kind_of Integer, boogie_dt.id
    assert_not_nil boogie_dt.id
    assert boogie_dt_id = boogie_dt.id # for later
    assert boogie_dt.name = 'Woogie'
    assert boogie_dt.save
    assert find_woogie_dt = DeviceType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie_dt
    assert_not_nil find_woogie_dt.first
    assert_kind_of DeviceType, find_woogie_dt.first
    assert woogie_dt = find_woogie_dt.first
    assert boogie_id = woogie_dt.id
    assert woogie_dt.destroy
    assert find_woogie_dt = DeviceType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie_dt
    assert_not_nil find_woogie_dt
    assert_nil find_woogie_dt.first
  end
end
