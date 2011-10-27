
#require 'torquebox_messaging'

class JmxProducer
  def run
    queue = TorqueBox::Messaging::Queue.new('/queues/jmx_query')
    MetricType.where(:name => 'JMX').first.metrics.each do |metric|
      metric.pollgroup.profiles.each do |profile|
        profile.device_type.devices.each do |device|
          queue.publish(({:metric_id => metric.id, :device_id => device.id}).to_yaml)
        end
      end
    end
  end
end