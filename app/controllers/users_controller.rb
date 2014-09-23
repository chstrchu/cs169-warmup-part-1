class UsersController < ApplicationController
  
  
  
  def create
    @user = User.new(user: params[:user], password: params[:password])
    
    @user.save
    redirect_to @user  
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def add
    user = User.new(user: params[:user], password: params[:password])
    user.add()
  end
 
  def login
    user = User.new(user: params[:user], password: params[:password])   
    user.login()
  end
  
  def testAPI_resetFixture
    user = User.new(user: "dummy")
    user.testAPI_resetFixture()
  end 
  
  
end

