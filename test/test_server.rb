require 'helper'

describe Dalli::Server do
  describe 'hostname parsing' do
    it 'handles no port or weight' do
      s = Dalli::Server.new('localhost')
      assert_equal 'localhost', s.hostname
      assert_equal 11211, s.port
      assert_equal 1, s.weight
    end

    it 'handles a port, but no weight' do
      s = Dalli::Server.new('localhost:11212')
      assert_equal 'localhost', s.hostname
      assert_equal 11212, s.port
      assert_equal 1, s.weight
    end

    it 'handles a port and a weight' do
      s = Dalli::Server.new('localhost:11212:2')
      assert_equal 'localhost', s.hostname
      assert_equal 11212, s.port
      assert_equal 2, s.weight
    end

    it 'handles ipv4 addresses' do
      s = Dalli::Server.new('127.0.0.1')
      assert_equal '127.0.0.1', s.hostname
      assert_equal 11211, s.port
      assert_equal 1, s.weight
    end

    it 'handles ipv6 addresses' do
      s = Dalli::Server.new('[::1]')
      assert_equal '::1', s.hostname
      assert_equal 11211, s.port
      assert_equal 1, s.weight
    end

    it 'handles ipv6 addresses with port' do
      s = Dalli::Server.new('[::1]:11212')
      assert_equal '::1', s.hostname
      assert_equal 11212, s.port
      assert_equal 1, s.weight
    end

    it 'handles ipv6 addresses with port and weight' do
      s = Dalli::Server.new('[::1]:11212:2')
      assert_equal '::1', s.hostname
      assert_equal 11212, s.port
      assert_equal 2, s.weight
    end

    it 'handles a FQDN' do
      s = Dalli::Server.new('my.fqdn.com')
      assert_equal 'my.fqdn.com', s.hostname
      assert_equal 11211, s.port
      assert_equal 1, s.weight
    end

    it 'handles a FQDN with port and weight' do
      s = Dalli::Server.new('my.fqdn.com:11212:2')
      assert_equal 'my.fqdn.com', s.hostname
      assert_equal 11212, s.port
      assert_equal 2, s.weight
    end
  end
end
