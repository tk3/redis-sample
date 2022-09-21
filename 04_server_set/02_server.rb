#!/usr/bin/env ruby

require "socket"

def parse_request(sock)
  response = sock.readline
  case response[0]
  when "*"
    params_length = response.chomp("\r\n").slice(1..).to_i
    puts "params_length: #{params_length}"
  else
    puts "Unknown message"
  end

  []
end

def do_request(sock)
  parse_request(sock)

  sock.write("OK\r\n")
end

gs = TCPServer.open("localhost", 12345)
addr = gs.addr
addr.shift
printf("server is on %s\n", addr.join(":"))

while true
  Thread.start(gs.accept) do |s|
    print(s, " is accepted\n")

    do_request(s)

    print(s, " is gone\n")
    s.close
  end
end

