require 'sinatra'
require 'data_mapper'

DataMapper.setup(
  :default,
  'mysql://root@localhost/people'  
)
# If you had a password:
# database://username:password@location/database_name

# Model
class Person
  include DataMapper::Resource

  # MySQL automatically gives EVERY object an ID
  # Migration: Whenever you change a field inside of a database
  # property: this is a keyword given to us from our DataMapper gem
  property :id, Serial
  property :first_name, String
  property :last_name, String
end

DataMapper.finalize.auto_upgrade!

# Controller
get '/' do
  @people = Person.all
  erb :root
end

get '/create_person' do
  erb :create_person
end

post '/create_person' do
  # params is a local variable that is ALWAYS included in sinatra routes
  # puts params
  @person = Person.create params[:person]
  # @person = Person.new params[:person]
  # @person.save

  redirect to('/')
end

get '/edit_person/:id' do
  @person = Person.get params[:id]
  erb :edit_person
end

put '/edit_person/:id' do
  @person = Person.get params[:id]
  @person.update params[:person]
  # This is the same as saying ^^
  # @person.first_name = params[:person][:first_name]
  # @person.last_name = params[:person][:last_name]
  # @person.save
  redirect to('/')
end

delete '/delete_person/:id' do
  puts params
  @person = Person.get params[:id]
  @person.destroy
  redirect to('/')
end