require 'socket'
require 'pry'

server = TCPServer.new 4567

html = <<HTML
<html>
  <head>Hello! This is my amazing web page</head>
  <body>
    <h1> This is my awesome site.</h1>
    <img src="random"/>
  </body>
</html>
HTML

def response(body, type = "text/html; charset=UTF-8")
<<RESPONSE
HTTP/1.1 200 OK
Location: http://localhost
Content-Type: #{type}
Date: #{Time.now}
Server: #{self.class}
Content-Length: #{body.length}
Alternate-Protocol: 80:quic, p=0.02

#{body}
RESPONSE
end

def parse(path)
  path[0].split(" ")[1]
end

while true # Only one person can connect at a time
  puts "waiting for connection"
  link = server.accept
  url = parse(link.recvmsg)

  if url.include? "image"
    link.puts response(File.read(Dir.pwd + url), "image/jpeg")
  elsif url.include? "random"
    link.puts response(File.read(Dir.glob("public/images/*.jpg").sample),
      "image/jpeg")
  else
    link.puts response(html)
  end
  link.close
end

