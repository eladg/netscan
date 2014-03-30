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

    def scan_ip(ip)
      scanner = Networker::PortScanner.new
      scanner.alive? ip
    end

    def showNetwork(ip, mask = 24)
      ipaddr = IPAddr.new ip
      puts ">>> will scan network: #{ipaddr.mask(mask)}/#{mask} "
      
      network = ipaddr.mask(mask)
      network.to_range.each do |ip|
        if scan_ip(ip)
          puts ">>> #{ip} does not seems to be alive"
        else
          puts ">>> #{ip} seems to be alive!"
        end
      end


    end
  end

end
