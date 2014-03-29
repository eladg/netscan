# Netscan

Simple network & port scanner written in Ruby on top of Sintra

## Interface

### get '/network'

Will return the network summary

### get '/scan/:host/:port'

Will print if could or could not connect to a certain host:port

### get '/scan/:host'

Will print a summary of open ports on a certain host
