#!/home/user/.rvm/rubies/ruby-2.1.0/bin/ruby

require 'pry'
require 'optparse'

  
  options = {}
  OptionParser.new do |opts|
    opts.on('-i', '--ip IP', String, 'target ip address') do |ip|
    options[:ip] = ip
  end
  
  opts.on('-t','--interval',String,'time interval between each scan in milliseconds') do |interval|
    options[:interval] = interval
  end
  
  opts.on('-pt','--protocol PROTOCOL',String,'protocol type [UDP/TCP/ICMP]') do |protocol|
    options[:protocol] = protocol
  end

  opts.on('-p','--port PORT',Integer,'Port to scan for') do |port|
    options[:port] = port
  end
  opts.on('-r','--range RANGE',String,'Specify a range to scan(192.168.1.100-192.168.1.200)') do |range|
    options[:range] = range
  end

  opts.on('-type','--TYPE',String,'Scan type [full,stealth,fin,syn]') do |type|
    options[:type] = type
  end
  opts.on('-b','--bannerGrabber',String,'bannerGrabber status (Should work only for TCP)') do |bannerGrabber|
    options[:bannerGrabber] = bannerGrabber
  end

  opts.on_tail('-h', '--help', 'Show help message') do
    puts opts
    exit
  end
end.parse!

def one_of?(options, *args)
if (options.keys & args).length != 1
  puts "Must specify one of #{args}. Try `netscan -h` for help"
  exit
end

#one_of?(options, :interface, :range, :cache)
#one_of?(options, :ping, :port, :nslookup)

netscan = NetworkScanner.new
