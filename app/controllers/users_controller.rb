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
    @return = user.add()
    render json: @return
  end
 
  def login
    user = User.new(user: params[:user], password: params[:password])   
    @return = user.login()
    render json: @return
  end
  
  def testAPI_resetFixture
    user = User.new(user: "dummy")
    @return = user.testAPI_resetFixture()
    render json: @return
  end 
  
  
end

