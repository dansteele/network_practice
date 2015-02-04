require "minitest/autorun"
require "rack/test"
require "pry"
require "./ornithology_server"

describe "OrnithologyApp" do
  include Rack::Test::Methods

  def app
    Sinatra::Application.new
  end

  before do
    app.settings.birds.merge! ({
      "robin" => "images/robin.jpg",
      "falcon" => "images/falcon.jpg",
      "swan" => "images/swan.jpg"
    })
  end
  
  describe "homepage" do
    before do
      get "/"
    end
    it "should show the homepage" do
      last_response.status.must_equal 200
    end
  end

  describe "birds" do

    it "should  show me a robin" do
      get '/birds/robin'
      assert last_response.ok?
      last_response.body.must_match(/<h2>Robin<\/h2>/)
      last_response.body.must_match(/robin.jpg/)
    end

    it "should  show me a falcon" do
      get '/birds/falcon'
      assert last_response.ok?
      last_response.body.must_match(/<h2>Falcon<\/h2>/)
      last_response.body.must_match(/falcon.jpg/)
    end

    it "should  show me a swan" do
      get '/birds/swan'
      assert last_response.ok?
      last_response.body.must_match(/<h2>Swan<\/h2>/)
      last_response.body.must_match(/swan.jpg/)
    end

  end

end