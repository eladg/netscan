require 'sinatra'
require 'json'
require './PortScanner.rb'
require './NetworkScanner.rb'

get '/' do
  return "hello world!"
end

get '/network' do
  networker = Networker::NetworkScanner.new
  return networker.showNetwork
end

get '/scan' do

end

get '/scan/:host/:port' do

  # print to server console
  puts ">>> scanning " + params[:host] + ":" + params[:port]

  scanner = Networker::PortScanner.new

  if scanner.open? params[:host], params[:port]
    "was able to connected to: " + params[:host] + ":" + params[:port]
  else
    "could not connect to: " + params[:host] + ":" + params[:port]
  end
end

get '/scan/:host' do

  # print to server console
  puts ">>> scanning host: " + params[:host]

  scanner = Networker::PortScanner.new
  open_ports = scanner.scan_host params[:host]

  open_ports.to_json
end
