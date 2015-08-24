ENV['RACK_ENV'] = 'test'
require 'rpsec'
require 'pg'
require 'sinatra/activerecord'
require 'task'
require 'list'

RSpec.configure do |config|
  config.after(:each) do
    Task.all().each do |task|
     task.destroy()
    end
    List.all().each() do |list|
      list.destroy()
    end
  end
end
