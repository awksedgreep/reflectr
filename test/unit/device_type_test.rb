require 'test_helper'

class DeviceTypeTest < ActiveSupport::TestCase
  fixtures :all
  
  test "device_type -> device relationship" do
    assert hornetq = DeviceType.where(:name => 'HornetQ Server').first
    assert_kind_of DeviceType, hornetq
    assert_not_nil hornetq
    assert hornetq_devices = hornetq.devices
    assert_kind_of Array, hornetq_devices
    assert_not_nil hornetq_devices
    assert_kind_of Device, hornetq_devices.first
    assert_not_nil hornetq_devices.first
    assert hornetq_devices.first.name == 'Reflectr HornetQ Server'
  end
  
  test "device_type -> profile relationship" do
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
  
  test "device_type crud" do
    assert boogie = DeviceType.create(:name => 'Boogie')
    assert_kind_of DeviceType, boogie
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
    assert find_woogie = DeviceType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie.first
    assert_kind_of DeviceType, find_woogie.first
    assert woogie = find_woogie.first
    assert boogie_id = woogie.id
    assert woogie.destroy
    assert find_woogie = DeviceType.where(:name => 'Woogie')
    assert_kind_of ActiveRecord::Relation, find_woogie
    assert_not_nil find_woogie
    assert_nil find_woogie.first
  end
end
