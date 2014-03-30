#!/home/user/.rvm/rubies/ruby-2.1.0/bin/ruby

require 'pry'
require 'optparse'

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
  puts ""
  exit
end

def usage()
  puts "syntax error."
  puts ""
  puts "./netscan.rb [command] [arguments]"
  exit
end

def main(args)
  
  if args.empty?
    usage()
  end

  if args[0] == "-h"
    show_help()
  end

  counter = 0
  options = Hash.new

  args.each do |argument|

    if argument[0] == '-'
      theArg = argument.dup
      theArg[0] = ''
      if args[counter+1].include? ','
        theValue = args[counter+1].dup
        options[theArg] = theValue.split ','
      elsif args[counter+1].include? '-'
        theValue = args[counter+1].dup
        options[theArg] = theValue
      else
        options[theArg] = args[counter+1]
      end 
      
    end

    counter+=1
  end


  puts options

end


main ARGV
