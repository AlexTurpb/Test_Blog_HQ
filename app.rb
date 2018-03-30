#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog_hq.db'

class Post < ActiveRecord::Base
	has_many :comments, :foreign_key => "postID"
 end

class Comment < ActiveRecord::Base
	belongs_to :posts, :foreign_key => "postID"
end





get '/' do
	erb :index
end

get '/new' do
	erb :new
end

post '/new' do

	
	erb :new
end