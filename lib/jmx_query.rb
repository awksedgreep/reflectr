require 'jmx4r'

class JmxQuery
  attr_accessor :config, :host, :port, :url, :prop, :connection, :result
  
  DefaultConfig = { :host => 'localhost', :port => 1090, :url => 'org.hornetq:module=Core,type=Queue,name=*,address=*',
                  :property => 'MessagesAdded' }
  
  def initialize(config = {})
    @config = DefaultConfig.merge(config)
    @host = @config[:host]
    @port = @config[:port]
    @url = @config[:url]
    @prop = @config[:property]      
  end
  
  def connect
    @connection = JMX::MBean.establish_connection(:host => @host, :port => @port)
  end
  
  def query(config = {})
    @config = DefaultConfig.merge(config) unless config.empty?
    @host = @config[:host]
    @port = @config[:port]
    @url = @config[:url]
    @prop = @config[:property]
    connect if @connection.nil?
    
    @result = []
    JMX::MBean.find_all_by_name(@url).each do |value|
      row = {}
      row[:url] = value.object_name
      row[:property] = @prop
      row[:value] = value.send(@prop.underscore)
      @result << row
    end
    @result
  end
  
  def close
    JMX::MBean.remove_connection
  end
end