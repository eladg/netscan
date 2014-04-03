require 'pry'
require 'socket'
include Socket::Constants

class BannerGrabber
  def analyze_web(host)

    host_ip = TCPSocket.gethostbyname(host)
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in(80,host_ip[3])
    socket.connect(sockaddr)
    socket.write("get / http/1.1\r\n\r\n")
    result = socket.read
    
    if result == nil
      puts "no response from the server"
      return "unknown"
    end    
    webServer = result.split("Server: ").last.split("\r\n").first

    if !result.include?("Server:")
      puts "didnt find Server:"
      socket.close
      return "unknown"
    end
    return knownWebServer(webServer.downcase)
  end

  def analyze_ftp(host)
    host_ip = TCPSocket.gethostbyname(host)
    socket = TCPSocket.open(host_ip[3],21)
    result = socket.gets
    
    if result.downcase.include?("ftpd") or result.include?("pure")
      socket.close
      return "Linux"
    elsif result.downcase.include?("filezila")
      sock.close
      return "windows"
    else
      socket.close
      return "unknown"
    end
  end

  def knownWebServer(webServer)
    case webServer
    when "iis 5.1"
      return "windows 2000"
    when "iis 8"
      return "windwos 8"
    when "nginx"
      return "Linux"
    when "apache"
      return "Linux"
    when "iweb"
      return "Mac"
    when "gws"
      return "google web server"
    else
      return "unknown"
    end
  end
end