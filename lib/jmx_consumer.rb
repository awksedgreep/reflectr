require 'jmx_query'

class JmxConsumer < TorqueBox::Messaging::MessageProcessor
  def on_message(body)
    @logger = TorqueBox::Logger.new( self.class )
    #@logger.warn body
    @jmx_hash = YAML::load(body)
    @device = Device.find(@jmx_hash[:device_id])
    @metric = Metric.find(@jmx_hash[:metric_id])
    #@logger.warn @metric.name
    #@logger.warn @device.name
    @result = JmxQuery.new(:host => @device.ip, :url => @device.url, :port => @metric.port, :property => @metric.property).query
    @logger.warn @result.to_s
    #Stat.process(:device_id => @device.id, :metric_id => @metric.id, :value => )
    @result.close
  end
end