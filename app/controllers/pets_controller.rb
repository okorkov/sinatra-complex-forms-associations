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
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
    else
      @owner = Owner.find(params[:owners][:owner][0])
    end
    @pet = Pet.new(name: params[:pet_name])
    @pet.owner_id = @owner
    @owner.pets << @pet
    @pet.save
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.all.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end


  patch '/pets/:id' do 
    puts params
    @pet = Pet.find(params[:id])
    if params[:new_owner][:name] == ""
      @owner = Owner.find(params[:owner][:name])
    else
      @owner = Owner.new
      @owner.name = params[:new_owner][:name]
    end
    @pet.name = params[:pet][:name]
    @owner.pets << @pet
    @pet.save
    @owner.save
    redirect to "pets/#{@pet.id}"
  end

end

