class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    if(!params[:owner][:name].empty?)
      @pet = Pet.new(params[:pet])
      @owner = Owner.create(params[:owner])
      @pet[:owner_id] = @owner.id
      @pet.save
    else
      @pet = Pet.create(params[:pet])
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    if(!params[:owner][:name].empty?)
      @owner = Owner.create(params[:owner])
      @pet[:name] = params[:name]
      @pet[:owner_id] = @owner.id
      @pet.save
    else
      @pet.update(params[:pet])
    end
    redirect to "pets/#{@pet.id}"
  end
end