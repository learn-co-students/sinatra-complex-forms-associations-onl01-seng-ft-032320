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
        if !params["owner_name"].empty?
            @pet.owner = Owner.create(name: params["owner_name"])
            @pet.save
        else
            @pet.owner = Owner.find_by(id: params["pet"]["owner_ids"])
            @pet.save
        end
        redirect to "pets/#{@pet.id}"
    end

    get '/pets/:id' do
        @pet = Pet.find(params[:id])
        erb :'/pets/show'
    end

    get '/pets/:id/edit' do
        @pet = Pet.find(params[:id])
        @owner = @pet.owner
        @owners = Owner.all
        erb :'/pets/edit'
    end

    patch '/pets/:id' do
        # binding.pry
        @pet = Pet.find(params[:id])
        @pet.name = params["pet_name"]
        if !params["owner_name"].empty?
            @pet.owner = Owner.create(name: params["owner_name"])
        else
            @pet.owner = Owner.find_by(id: params["pet"]["owner_ids"][0])
        end
        @pet.save
        redirect to "pets/#{@pet.id}"
    end
end
