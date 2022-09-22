#!/usr/bin/env ruby

require "socket"


class RedisServer
  def initialize(host, port)
    @db = {}
    @gs = TCPServer.open("localhost", 12345)
  end

  def addr
    @gs.addr
  end

  def accept
    @gs.accept
  end

  def start
    while true
      Thread.start(accept) do |s|
        print(s, " is accepted\n")
 
        begin
          while true do
            do_request(s)
          end
        rescue EOFError => e
        end
 
        print(s, " is gone\n")
        s.close
      end
    end
  end

  private
  def do_request(sock)
    request =  parse_request(sock)
    p request
    case request[0].upcase
    when "GET"
      if request.length < 2
        sock.write("-ERR wrong number of arguments for 'get' command\r\n")
      else
        if @db.key?(request[1])
          value = @db[request[1]]
          sock.write("$#{value.length}\r\n#{value}\r\n")
        else
          sock.write("$-1\r\n")
        end
      end
    when "SET"
      if request.length < 3
        sock.write("-ERR wrong number of arguments for 'set' command\r\n")
      else
        @db[request[1]] = request[2]
        sock.write("+OK\r\n")
      end
    when "COMMAND"
      sock.write("*0\r\n")
    else
      puts "Unknown request type"
    end
  end

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
end

if __FILE__ == $0
  server = RedisServer.new("localhost", 12345)
  addr = server.addr
  addr.shift
  printf("server is on %s\n", addr.join(":"))

  server.start
end

