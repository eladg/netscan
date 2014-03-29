require 'socket'

module Networker

  class PortScanner

    def port_range()
      (10..80)
    end

    def open? (host, port)
      sock = Socket.new(:INET, :STREAM)
      raw = Socket.sockaddr_in(port, host)
      begin
        sock.connect(raw)
        true
      rescue
        false
      end
    end

    def open_syn? (host, port)
      false
    end

    def open_syn_ack? (host, port)
      false
    end

    def open_ack? (host, port)
      false
    end

    def open_udp? (host, port)
      false
    end

    def open_fin_scan? (host, port)
      false
    end

    def open_port(host, port)
      sock = Socket.new(:INET, :STREAM)
      raw = Socket.sockaddr_in(port, host)

      rescue (Errno::ECONNREFUSED)
        rescue(Errno::ETIMEDOUT)
    end

    def scan_host(host)
      open_ports = []
      for port in port_range()
        puts ">>> scanning port: " + port.to_s
        sleep 0.01
        if open? host, port
          puts ">>> found open port at: #{host}:#{port}"
          open_ports << port
        end
      end
      open_ports
    end

  end

end
