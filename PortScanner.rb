require 'socket'
require 'timeout'
require 'pry'

class PortScanner

  def initialize(host,timeout = 1)
    @host = TCPSocket.gethostbyname(host)[3]
    @timeout = timeout
  end

  def port_range()
    (50..80)
  end

  def open? (host, port)
    sock = Socket.new(:INET, :STREAM)
    raw = Socket.sockaddr_in(port, host)
    Timeout::timeout(@timeout) do
      sock.connect(raw)
      true
    end 
  rescue Timeout::Error
      false
  end

  def open_syn?(host, port)
    false
  end

  def open_syn_ack?(host, port)
    false
  end

  def open_ack?(host, port)
    false
  end

  def open_udp?(host, port)
    false
  end

  def open_fin_scan?(host, port)
    false
  end

  def scan_host
    @open_ports = []
    for port in port_range()
      puts ">>> scanning port: "+port.to_s
      if open? @host, port
        puts ">>> found open port at: #{@host}:#{port}"
        @open_ports << port
      end
    end
    puts @open_ports
  end
end