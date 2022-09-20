#!/usr/bin/env ruby

require "socket"

s = TCPSocket.open("localhost", 12345)

while gets
  s.write($_)
  print(s.gets)
end
s.close

