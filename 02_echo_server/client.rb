#!/usr/bin/env ruby

require "socket"

port = if ARGV.size > 0 then ARGV.shift else 6379 end
puts "connect to localhost:#{port}"

s = TCPSocket.open("localhost", port)

while gets
  s.write($_)
  print(s.gets)
end
s.close

