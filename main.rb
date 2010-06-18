require "rubygems"
require "sinatra"
require "haml"
require "sass"
require "main"
require "lib/numlet"


before do headers "Content-Type" => "text/html; charset=utf-8" end

get '/style.css' do content_type 'text/css', :charset => 'utf-8'; sass :style; end

get "/" do
  haml :index
end

get "/ajax/:number" do
  @number = params[:number].scan(/\d/).join("").to_i
  @words = {"English" => @number.to_cardinal, "Spanish" => @number.to_cardinal('es'), 
    "German" => @number.to_cardinal('de'), "French" => @number.to_cardinal('fr')}
  haml :x_number, :layout => false
end


get "/API/:number/?" do
  num = params[:number].scan(/\d/).join("").to_i
  return num.to_cardinal('en')
end

get "/API/:number/:lang" do
  num = params[:number].scan(/\d/).join("").to_i
  return num.to_cardinal(params[:lang])
end

get "/API/" do
  num = params[:number].scan(/\d/).join("").to_i
  lang = (params[:lang].nil? || params[:lang].empty?) ? 'en' : params[:lang]
  return num.to_cardinal(lang)
end