require './PortScanner.rb'
require 'ipaddr'

module Networker

  class NetworkScanner

    def local_ip
      orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

      UDPSocket.open do |s|
        s.connect '8.8.4.4', 1
        s.addr.last
      end
    ensure
      Socket.do_not_reverse_lookup = orig
    end

    def showNetwork(mask = 24)
      ipaddr = IPAddr.new local_ip
      puts ">>> will scan network: #{ipaddr.mask(mask)}"
    end
  end

end
