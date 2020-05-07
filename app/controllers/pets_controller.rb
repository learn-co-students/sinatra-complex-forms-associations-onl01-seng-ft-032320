class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    #binding.pry
    @pet = Pet.create(name: params[:pet_name])
    if params[:owner][:name] == ""
      @pet.owner = Owner.find(params[:owner_id])
    else 
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    #binding.pry
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit' 
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    
    @pet.update(name: params[:pet_name])
   #binding.pry
    if params[:owner][:name] == ""
      @pet.owner = Owner.find_by_id(params[:owner_id])
    else 
      @pet.owner = Owner.create(params[:owner])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end