require 'socket'
require 'timeout'
require 'pry'

class PortScanner

  def initialize(host,timeout = 1,interval = 5)
    @host = TCPSocket.gethostbyname(host)[3]
    @timeout = timeout
    @interval = interval
  end

  def port_range()
    (50..60)
  end

  def open_tcp? (port)
    sock = Socket.new(:INET, :STREAM)
    raw = Socket.sockaddr_in(port, @host)

    begin
      Timeout::timeout(@timeout) do
        sock.connect(raw)
      end       
      sock.close
      return true
    rescue Timeout::Error
      sock.close
      return false
    end
  end

  def open_udp?(port)
    uSocket = UDPSocket.new
    uSocket.send("daaslkgjlaskjglkasjglaskjglasjasgasg", 0, @host, port)
    begin
      
      Timeout::timeout(@timeout) do
        if uSocket.recvfrom(1024) != nil
          uSocket.close
          return true          
        end
        uSocket.close
        return false
      end

    rescue Timeout::Error
      uSocket.close
      return false
    end
  end

  def scan_host(type)
    @open_ports = []
    for port in port_range()
      puts ">>> scanning port: "+port.to_s
      case type
      when "tcp"
        if open_tcp? port
          puts ">>> found open port at: #{@host}:#{port}"
          @open_ports << port
        end
      when "udp"
        if open_udp? port
          puts ">>>found open port at: #{@host}:#{port}"
          @open_ports << port
        end
      end
      sleep @interval
    end
    puts @open_ports
  end
end