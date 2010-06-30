require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'


#  set :static, true
 # set :public, File.dirname(__FILE__) + '/public'

get '/' do
  haml :index

end

get '/say/*/to/*' do
  "splatted #{params["splat"]}"
end

get '/post' do

end



#SauRupiya.run!
