require 'sinatra'

get '/' do
  return "hello world!"
end

get '/:name' do
  return "hello " + params[:name] + "!"
end
