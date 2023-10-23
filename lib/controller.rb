require 'gossip'
require 'comments'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip: Gossip.find(params[:id].to_i), id: params[:id]}
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip: Gossip.find(params[:id].to_i), id: params[:id]}
  end

  post '/gossips/:id/edit' do
    Gossip.update(params[:id].to_i, params["gossip_author"], params["gossip_content"])
    redirect '/'
  end

  post '/comments/new' do
    Comments.new(params[:id], params["author"], params["content"]).save
    redirect "/gossips/#{params[:id]}"
  end
end