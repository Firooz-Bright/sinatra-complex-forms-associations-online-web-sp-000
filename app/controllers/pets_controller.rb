class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owner= Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    
     @pet = Pet.create(params[:pet])
     
    redirect to "pets/#{@pet.id}"	    
    
    if ! Owner.find_by_id(params["pet"]["owner_id"])
       @pet.owner = Owner.create(params[:owner])
    else
      
       @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
      
    end
    
    @pet.save
      redirect "pets/#{@pet.id}"
   
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    
    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    
    erb :'/pets/edit'
  end
  

  post  '/pets/:id' do 
    
     if !params[:pet].keys.include?("owner_id")
       params[:pet]["owner_id"] = []
       end
       

     @pet = Pet.find(params[:id]).empty?
        @pet.update(params["pet"]["name"])
       @pet.name = params["pet"]["name"]
     
       if !params["owner"]["name"].empty?
        # @pet.owner.name = params["owner"]["name"]
        @pet.owner = Owner.create(name: params["owner"]["name"])
       else
        @pet.owner = Owner.find_by_id(params["pet"]["owner_id"])
        end
      @pet.save
       redirect "pets/#{@pet.id}"
    
  end
end