require "sinatra"
require "sinatra/partial"
require "active_record"
require "sqlite3"
require "pry"

require "./models/bird"

configure do
  db_config = YAML.load_file('db/config.yml')["development"]

  ActiveRecord::Base.establish_connection(
      :adapter => db_config["adapter"],
      :database => db_config["database"]
    )

end

set :birds, {}
set :partial_template_engine, :erb
enable :partial_underscores

get "/" do
  @bird = Bird.bird_of_the_day
  erb :homepage,
  :layout => :my_amazing_layout, :layout_options => { :views => 'views/layouts' }
end

get '/birds/:bird' do
  @bird = Bird.find_by_name(params[:bird])
  erb :bird_page,
  :layout => :my_amazing_layout, :layout_options => { :views => 'views/layouts' }
end

get '/new' do
  erb :bird_form,
  :layout => :my_amazing_layout, :layout_options => { :views => 'views/layouts' }
end

post '/create' do
  bird = Bird.new(params)
  bird.save
  redirect "birds/#{bird.name}"
end