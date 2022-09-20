#!/usr/bin/env ruby

require "socket"

gs = TCPServer.open("localhost", 12345)
addr = gs.addr
addr.shift
printf("server is on %s\n", addr.join(":"))

def parse_request(sock)
end

def do_request(sock)
  parse_request(sock)

  sock.write("OK\r\n")
end

while true
  Thread.start(gs.accept) do |s|
    print(s, " is accepted\n")

    do_request(s)

    print(s, " is gone\n")
    s.close
  end
end

