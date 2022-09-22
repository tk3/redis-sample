#!/usr/bin/env ruby

require "socket"

port = if ARGV.size > 0 then ARGV.shift else 6379 end
puts "port: #{port}"

class RedisClient
  def initialize(host, port)
    @sock = TCPSocket.open(host, port)
  end

  def get(key)
    @sock.write(make_request(["get", "hello"]))
    response = @sock.readline
    p response

    response = @sock.readline
    p response
  end

  def set(key, value)
    @sock.write(make_request(["set", key, value]))

    response = @sock.readline
    p response
  end

  private
  def make_request(arr)
    arr.inject("*#{arr.length}\r\n") do |result, item|
      result + "$#{item.length}\r\n" + "#{item}\r\n"
    end
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

