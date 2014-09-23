class UsersController < ApplicationController
  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2
  ERR_BAD_USERNAME = -3
  ERR_BAD_PASSWORD = -4
  
  
  def create
    @user = User.new(user: params[:user], password: params[:password])
    
    @user.save
    redirect_to @user  
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def add
    User.add(user: params[:user], password: params[:password])
  end
 
  def login   
    User.login(user: params[:user], password: params[:password])
  end
  
  def TESTAPI_resetFixture
     User.testAPI_resetFixture()
  end 
  
  
end

