require 'pry'
class OwnersController < ApplicationController

  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index' 
  end

  get '/owners/new' do 
    @pets = Pet.all
    erb :'/owners/new'
  end

  post '/owners' do 

    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
      #binding.pry
    end 
    #@owner.save is not neeed it becase the pet was created so already save
    #binding.pry 
    redirect "/owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    ####### bug fix
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
      end
      #######
     
      @owner = Owner.find(params[:id])
      #params[:owner] = {"name"=>"Susan", "pet_ids"=>["4"]}, This will create even the new pets that were selected 
      @owner.update(params["owner"])
      if !params["pet"]["name"].empty?
        @owner.pets << Pet.create(name: params["pet"]["name"])
      end
      redirect "owners/#{@owner.id}" 
  end
end