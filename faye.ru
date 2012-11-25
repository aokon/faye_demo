require 'faye'
require './lib/faye/messages_service.rb'


Faye::WebSocket.load_adapter('thin')
faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
faye_server.add_extension MessagesService.new
run faye_server
