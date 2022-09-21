#!/usr/bin/env ruby

require "socket"

def parse_request(sock)
  response = sock.readline
  case response[0]
  when "*"
    params_length = response.chomp("\r\n").slice(1..).to_i
    puts "params_length: #{params_length}"

    param_value = []

    params_length.times do
      param_value << parse_request(sock)
    end
  when "$"
    param_length = response.chomp("\r\n").slice(1..).to_i

    response = sock.readline
    param_value = response.chomp("\r\n").slice(0, param_length)
  else
    puts "Unknown message"
  end

  param_value
end

def do_request(sock)
  p parse_request(sock)

  sock.write("OK\r\n")
end

if __FILE__ == $0
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
end

