require 'test/unit'
require 'stringio'
require './server'

class TC_Server < Test::Unit::TestCase
  def test_array
    r = "*3\r\n" +
        "$3\r\n" +
        "set\r\n" +
        "$4\r\n" +
        "abcd\r\n" +
        "$10\r\n" +
        "0123456789\r\n"
    sio = StringIO.new(r, 'r+')
    request = parse_request(sio)
    assert_equal(3, request.length)
    assert_equal("set", request[0])
    assert_equal("abcd", request[1])
    assert_equal("0123456789", request[2])
  end

  def test_only_bulk_string
    r = "$4\r\n" +
        "abcd\r\n"
    sio = StringIO.new(r, 'r+')
    request = parse_request(sio)
    assert_equal(4, request.length)
    assert_equal("abcd", request)
  end
end

