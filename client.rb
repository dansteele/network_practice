require 'socket'
require 'pry'

socket = TCPSocket.new 'localhost', 4567
puts socket.read