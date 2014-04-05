require 'ipaddr'
require 'timeout'

module Enumerable
  def index_by
    if block_given?
      Hash[map { |elem| [yield(elem), elem] }]
    else
      to_enum :index_by
    end
  end
end

class NetworkScanner
  
  def initialize(timeout = 0.5)
    @timeout = timeout
  end

  def get_network_by_interface(interface)

    ifconfig = `ifconfig`.split("\n\n").index_by{|x| x[/\w+/,0]}
    inet = ifconfig[interface][/inet addr:([^\s]*)/, 1].split('.')
    broadcast = ifconfig[interface][/Bcast:([^\s]*)/, 1].split('.')
    mask = ifconfig[interface][/Mask:([^\s]*)/, 1].split('.')

    start_first = inet[0].to_i & mask[0].to_i
    start_second = inet[1].to_i & mask[1].to_i
    start_third = inet[2].to_i & mask[2].to_i
    start_fourth = inet[3].to_i & mask[3].to_i

    first_range = start_first..broadcast[0].to_i
    second_range = start_second..broadcast[1].to_i
    third_range = start_third..broadcast[2].to_i
    fourth_range = start_fourth..broadcast[3].to_i
     
    @ips_to_check = []
    first_range.each do |first|
      second_range.each do |second|
        third_range.each do |third|
          fourth_range.each do |fourth|
            @ips_to_check << "#{first}.#{second}.#{third}.#{fourth}"
          end
        end
      end
    end
    puts "Checking ips in (#{first_range}).(#{second_range}).(#{third_range}).(#{fourth_range})"
    
    @ips_to_check
  end 

  def pinger
    binding.pry
    @livehosts = []
    @ips_to_check.each do |ip|
      if(ip.split(".").last != "0" || ip.split(".").last != "255")
        if alive?(ip)
          @livehosts << ip
        end
      end
    end
    puts @livehosts
  end

  def alive?(host)
    puts "Checking host: #{host}"
    Timeout::timeout(@timeout) do
      result = `ping -c 1 #{host}`
      if result.include?("time=")
        return true
      end
    end
  rescue
    return false
  end
end