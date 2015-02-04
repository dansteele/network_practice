require "sinatra"
require "sinatra/partial"

set :birds, {}
set :partial_template_engine, :erb
enable :partial_underscores

get "/" do
  erb :homepage, :locals => {:bird_img => settings.birds["falcon"], :bird => "falcon"},
  :layout => :my_amazing_layout, :layout_options => { :views => 'views/layouts' }
end

get '/birds/:bird' do
  bird_img = settings.birds[params[:bird]]
  erb :bird_page, :locals => {:bird_img => bird_img, :bird => params[:bird]}
end