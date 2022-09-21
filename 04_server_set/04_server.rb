#!/usr/bin/env ruby

require "socket"

def parse_request(sock)
  params = []

  response = sock.readline
  case response[0]
  when "*"
    params_length = response.chomp("\r\n").slice(1..).to_i
    puts "params_length: #{params_length}"

    params_length.times do |i|
      response = sock.readline
      case response[0]
      when "$"
        param_length = response.chomp("\r\n").slice(1..).to_i

        response = sock.readline
        param_value = response.chomp("\r\n").slice(0, param_length)

        puts "param[#{i}]: length: #{param_length}, value: #{param_value}"

        params << param_value
      else
        puts "Unknown message"
      end
    end
  else
    puts "Unknown message"
  end

  params
end

def do_request(sock)
  p parse_request(sock)

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

