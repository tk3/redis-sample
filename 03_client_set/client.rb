#!/usr/bin/env ruby

require "socket"

port = if ARGV.size > 0 then ARGV.shift else 6379 end
puts "port: #{port}"

s = TCPSocket.open("localhost", port)

s.write("*3\r\n" +
        "$3\r\n" +
        "set\r\n" +
        "$4\r\n" +
        "abcd\r\n" +
        "$10\r\n" +
        "0123456789\r\n")

r = s.readline
p r

s.close

