#!/usr/bin/env ruby

require "socket"

port = if ARGV.size > 0 then ARGV.shift else 6379 end
puts "port: #{port}"

s = TCPSocket.open("localhost", port)

s.write("*2\r\n" +
        "$3\r\n" +
        "get\r\n" +
        "$5\r\n" +
        "hello\r\n")

response = s.readline
p response

response = s.readline
p response

s.close
