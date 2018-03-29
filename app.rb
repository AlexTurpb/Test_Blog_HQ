#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog_hq.db'

class Post < ActiveRecord::Base
	has_many :comments, :foreing_key => "postID"
 end

class Comment < ActiveRecord::Base
	belongs_to :posts, :foreing_key => "postID"
end





get '/' do
	erb :index
end