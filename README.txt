# Netscan By Or Gariany

Simple network & port scanner written in Ruby on top of Sintra 

#installing ruby-rvm 2.1.1 on ubuntu

\curl -sSL https://get.rvm.io | bash
rvm install "2.1.1"
rvm use "2.1.1"  -  !! you might need to change your terminal emulator preferences to allow login shell. !!

Usage: netscan [options]
    -b, --bannerGrabber              BannerGrabber status (works only for TCP)
    -n, --networkMapper Interface    Mapping the entire network using ICMP
    -p, --Port                       Start port scanning tool (1-1024)
    -i, --ip Host                    target ip address
    -t, --Type type                  connection type [udp/tcp]
    -h, --help                       Show help message

usage examples:

./netscan -n eth0
./netscan -p -i google.com -t tcp
./netscan -p -i google.com -t udp
./netscan -b -i ftp.foolabs.com