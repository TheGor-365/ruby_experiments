module Connection
  def self.add_connection_variable(name)
    define_method name do
      instance_variable_get "@#{name}"
    end

    define_method "#{name}=" do |value|
      instance_variable_set "@#{name}", value
    end
  end

  add_connection_variable :timeout
  add_connection_variable :protocol
  add_connection_variable :something
end


pp connection = Connection.add_connection_variable(:timeout)

pp connection
pp connection.instance_variables; puts



pp connection.protocol
pp connection.protocol = 'qnq'
pp connection.instance_variables; puts



pp connection
pp connection.protocol = 'ssh'
pp connection; puts



pp connection.something
connection.something = 'something else'
pp connection.something; puts



pp connection.instance_variables
pp connection
