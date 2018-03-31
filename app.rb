#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog_hq.db'

class Post < ActiveRecord::Base
	validates :post, presence: true
	validates :author, presence: true
	has_many :comments, :foreign_key => "post_id"
	
	
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
	if @post.save
		@info = 'Post saved'
		erb :new
	else
		@error = @post.errors.full_messages.first
		erb :new
	end
end

get '/post/:id' do
	erb :post
end

post '/post/:id' do
	
	@comment= Comment.new params[:comment]
	@comment.save
	erb :post
end