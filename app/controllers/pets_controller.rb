class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @pets = Pet.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner << Pet.create(name: params["owner"]["name"])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    if !params[:pets].keys.include?("owner_ids")
      params[:pets]["owner_ids"] = []
    end
    @pet = Pet.find(params[:id])
    @owner.update(params["owner"])
    if !params["owner"]["name"].empty?
      @owner.pets << Pet.create(name: params["owner"]["name"])
    end
    redirect to "pets/#{@pet.id}"
  end
end
