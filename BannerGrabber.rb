require 'socket'
require 'timeout'
include Socket::Constants

class BannerGrabber
  
  def initialize(host,timeout = 2)
    @host = TCPSocket.gethostbyname(host)[3]
    @timeout = timeout
  end
  
  def analyze_host
    result = analyze_web
    if result == "unknown OS"
      result = analyze_ftp
    end
    return result
  end

  #creates a TCP socket over port 80 and submit a get request.
  #it is looking for the string: "server:" and decides what is the operating system of that server.
  def analyze_web
    socket = Socket.new( AF_INET, SOCK_STREAM, 0 )
    sockaddr = Socket.pack_sockaddr_in(80,@host)
    socket.connect(sockaddr)
    socket.write("get / http/1.1\r\n\r\n")
    result = socket.read
    if result == nil
      puts "no response from the server"
      return "unknown OS"
    end    
    webServer = result.split("Server: ").last.split("\r\n").first

    if !result.include?("Server:")
      puts "didnt find Server:"
      socket.close
      return "unknown OS"
    end
    return knownWebServer(webServer.downcase)
  end


  #creates a TCP socket over port 21 and recives the server responce.

  def analyze_ftp
    begin
      Timeout::timeout(@timeout) do
        socket = TCPSocket.open(@host,21)
        result = socket.gets    
      end
    rescue Timeout::Error
      return "unknown OS"
    end
    
    if result.downcase.include?("ftpd") or result.include?("pure")
      socket.close
      return "Linux"
    elsif result.downcase.include?("filezila")
      sock.close
      return "windows"
    else
      socket.close
      return "unknown OS"
    end
  end

  #DB if web known web servers 
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
      return "unknown OS"
    end
  end
end