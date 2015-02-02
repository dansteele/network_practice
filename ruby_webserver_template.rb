# Server
require 'socket'

server = TCPServer.new 4567

while true # Only one person can connect at a time
  link.puts "waiting for connection"
  link = server.accept
  link.puts "hi"
  link.close
end


[-------------------------------------------]


# Client
require 'socket'

socket = TCPSocket.new 'localhost', 4567
puts socket.read