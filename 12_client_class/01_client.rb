#!/usr/bin/env ruby

require "socket"

port = if ARGV.size > 0 then ARGV.shift else 6379 end
puts "port: #{port}"

class RedisClient
  def initialize(host, port)
    @sock = TCPSocket.open(host, port)
  end

  def get(key)
    @sock.write("*2\r\n" +
                "$3\r\n" +
                "get\r\n" +
                "$5\r\n" +
                "hello\r\n")
    response = @sock.readline
    p response

    response = @sock.readline
    p response
  end

  def set(key, value)
    @sock.write("*3\r\n" +
                "$3\r\n" +
                "set\r\n" +
                "$#{key.length}\r\n" +
                "#{key}\r\n" +
                "$#{value.length}\r\n" +
                "#{value}\r\n")

    response = @sock.readline
    p response
  end

  class << self
    def close(client)
      client.instance_eval do
        @sock.close
      end
    end
  end
end

client = RedisClient.new("localhost", port)

client.set("hello", "world!")

client.get("hello")

RedisClient.close(client)

