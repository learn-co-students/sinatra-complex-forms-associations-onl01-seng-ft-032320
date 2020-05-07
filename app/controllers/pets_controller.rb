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
    @pet = Pet.create(name: params[:pet_name])
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(params[:owner])
    else
      @pet.owner = Owner.find_by(id: params[:pet][:owner_id])
    end
    @pet.save
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    if @pet
      erb :'/pets/edit'
    else
      redirect "/pets/index"
    end
  end

  patch '/pets/:id' do 
    @pet = Pet.find_by_id(params[:id])
    @pet.update(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "pets/#{@pet.id}"
  end
end