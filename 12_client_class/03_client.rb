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

    response = parse_response(@sock)
    p response
    response
  end

  def set(key, value)
    @sock.write(make_request(["set", key, value]))

    response = parse_response(@sock)
    p response
    response
  end

  private
  def make_request(arr)
    arr.inject("*#{arr.length}\r\n") do |result, item|
      result + "$#{item.length}\r\n" + "#{item}\r\n"
    end
  end

  def parse_response(sock)
    response = sock.readline
    case response[0]
    when "+"
      value = response.chomp("\r\n").slice(1..)
    when "$"
      param_length = response.chomp("\r\n").slice(1..).to_i

      response = sock.readline
      value = response.chomp("\r\n").slice(0, param_length)

      puts "param) length: #{param_length}, value: #{value}"
    else
      puts "Unknown message"
    end

    value
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

