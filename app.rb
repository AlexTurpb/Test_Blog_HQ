#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:blog_hq.db'

class Post < ActiveRecord::Base
	validates :post, presence: true, length: { in: 4..20 }
	validates :author, presence: true, length: { in: 4..20 }
	has_many :comments, :foreign_key => "post_id"
end

class Comment < ActiveRecord::Base
	validates :comment, presence: true, length: { in: 4..20 }
	validates :author, presence: true, length: { in: 4..20 }
	belongs_to :posts, :foreign_key => "post_id"
end


get '/' do
	erb :index
end

get '/new' do
	@po = Post.new
	erb :new
end

post '/new' do
	@po = Post.new params[:post]
	if @po.save
		@info = 'Post saved'
		erb :new
	else
		@error = @po.errors.full_messages.first
		erb :new
	end
end

get '/post/:id' do
	@co = Comment.new
	erb :post
end

post '/post/:id' do
	params[:comment].store("post_id", params[:id])
	@co = Comment.new params[:comment]
	if @co.save
		@info = "Comment successful"
		erb :post
	else
		@error = @co.errors.full_messages.first
		erb :post
	end
end