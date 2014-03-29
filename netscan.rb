#!/usr/bin/ruby

require 'pry'

def show_help()
  puts ""
  puts "./netscan.rb [command] [arguments]"
  puts ""
  puts "-ip   target ip address"
  puts "-t    time interval between each scan in milliseconds"
  puts "-pt   protocol type [UDP/TCP/ICMP]"
  puts "-p    ports [ can be range : -p 22-54 , can be single port : -p 80 , can be combination : -p 80,43,23,125]"
  puts "-type scan type [full,stealth,fin,ack]"
  puts "-b    bannerGrabber status (Should work only for TCP)"
end

def usage()
  puts "syntax error."
  puts ""
  puts "./netscan.rb [command] [arguments]"
  exit
end

def main(args)
  # binding.pry
  command = args.first
  if command.nil?
    usage()
  end

  if command == "-h"
    show_help()
  end

end


main ARGV
