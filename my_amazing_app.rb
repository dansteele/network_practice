require 'sinatra'



get '/' do
  erb :index
end

post '/' do
  erb :index # params is passed
end

