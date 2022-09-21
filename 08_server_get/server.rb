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

    puts "param) length: #{param_length}, value: #{param_value}"
  else
    puts "Unknown message"
  end

  param_value
end

DB = {}

def do_request(sock)
  request =  parse_request(sock)
  p request
  case request[0].upcase
  when "GET"
    value = DB[request[1]]
    sock.write("$#{value.length}\r\n#{value}\r\n")
  when "SET"
    DB[request[1]] = request[2]
    sock.write("+OK\r\n")
  else
    puts "Unknown request type"
  end
end

if __FILE__ == $0
  gs = TCPServer.open("localhost", 12345)
  addr = gs.addr
  addr.shift
  printf("server is on %s\n", addr.join(":"))

  while true
    Thread.start(gs.accept) do |s|
      print(s, " is accepted\n")

      while true do
        do_request(s)
      end

      print(s, " is gone\n")
      s.close
    end
  end
end

