#!/usr/bin/env ruby

require 'optparse'
require "./BannerGrabber"
require "./NetworkScanner"
require "./PortScanner"


## This project was Written by Or Gariany

options = {}
OptionParser.new do |opts|

  opts.on('-b','--bannerGrabber',String,'BannerGrabber status (works only for TCP)') do |bannerGrabber|
    options[:bannerGrabber] = true
  end

  opts.on('-n','--networkMapper Interface',String,'Mapping the entire network using ICMP') do |interface|
    options[:network] = interface
  end

  opts.on('-p','--Port',String,'Start port scanning tool') do |port|
    options[:port] = true
  end

  opts.on('-i', '--ip Host', String, 'target ip address') do |ip|
    options[:ip] = ip
  end

  opts.on('-t','--Type type',String,'connection type [udp/tcp]') do |type|
    options[:type] = type
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
end

one_of?(options, :bannerGrabber,:network,:port)

if options[:bannerGrabber]
  one_of?(options, :ip)
  bg = BannerGrabber.new(options[:ip])
  puts bg.analyze_host
end

if options[:network]
  networkMapper = NetworkScanner.new
  networkMapper.get_network_by_interface(options[:network])
  networkMapper.pinger
end

if options[:port]
  one_of?(options, :ip)
  one_of?(options, :type)
  ps = PortScanner.new(options[:ip])
  ps.scan_host(options[:type])
end