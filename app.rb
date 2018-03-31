#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog_hq.db'

class Post < ActiveRecord::Base
	has_many :comments, :foreign_key => "post_id"
	validates :post, presense: true
	validates :author, presense: true
 end

class Comment < ActiveRecord::Base
	belongs_to :posts, :foreign_key => "post_id"
end

get '/' do
	erb :index
end

get '/new' do
	erb :new
end

post '/new' do
	@post= Post.new params[:post]
	@post.save
	erb :new
end

get '/post/:id' do
	erb :post
end

post '/post/:id' do
	
	@comment= Comment.new params[:comment]
	@comment.save
	erb :post
end