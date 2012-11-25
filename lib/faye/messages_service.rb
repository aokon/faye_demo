require 'logger'
require 'active_record'
require 'yaml'
require File.expand_path('../../../app/models/message.rb', __FILE__)

class MessagesService

  def initialize
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    ActiveRecord::Base.configurations = YAML::load(File.read(File.expand_path('../../../config/database.yml', __FILE__)))
    ActiveRecord::Base.establish_connection( ENV['FAYE_ENV']  || 'development')
  end

  def incoming(message, callback)

    if message['channel'] == '/messages/new'
      params = { content: message['data'] }
      Message.create! params
    end
    callback.call(message)
  end

end
