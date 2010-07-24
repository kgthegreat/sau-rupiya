require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
#require 'sinatra/mongoid'
require 'mongo'

include Mongo

DB = Connection.new(ENV['DATABASE_URL'] || 'localhost').db('100-rupee')
if ENV['DATABASE_USER'] && ENV['DATABASE_PASSWORD']
  auth = DB.authenticate(ENV['DATABASE_USER'], ENV['DATABASE_PASSWORD'])
end
TASKS = DB.collection('tasks')

configure :production do
  enable :raise_errors
end

#set :mongo_db, '100rupee'

#  set :static, true
 # set :public, File.dirname(__FILE__) + '/public'

get '/' do
  haml :index

end

get '/say/*/to/*' do
  "splatted #{params["splat"]}"
end

put '/post' do
  record = {"task"=> params['task'], "coins" => params['coins'], "task-type" => params['task-type'], "submit-time" => Time.now}
  TASKS.insert(record)
  redirect('/')
end

get '/pay' do
 @money_bringing_tasks = TASKS.find("task-type" => "pay")
 haml :pay
end

get '/take' do
  @money_draining_tasks = TASKS.find("task-type" => "take")
  haml :take
end



#SauRupiya.run!
