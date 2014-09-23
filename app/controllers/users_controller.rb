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
    @user = User.new(user: params[:user], password: params[:password], count: 1)
    name = User.find_by user: params[:user]
    if name != nil
      print ERR_USER_EXISTS
      return ERR_USER_EXISTS
    end
    if params[:user].length > 128 or params[:user] == nil
      print ERR_BAD_USERNAME
      return ERR_BAD_USERNAME
    end
    if params[:password].length > 128
      print ERR_BAD_PASSWORD
      return ERR_BAD_PASSWORD
    else
      @user.save
      
      print SUCCESS
      return SUCCESS
    end
  end
 
  def login   
    if User.find_by user: params[:user] == nil
      print ERR_BAD_CREDENTIALS
      return ERR_BAD_CREDENTIALS
    else
      user = User.find_by user: params[:user]
      user.count = user.count + 1
      user.save
      print user.count
      return user.count
    end
  end
  
  def TESTAPI_resetFixture
     @user = User.all
     @user.destroy
     return SUCCESS
  end 
  
  
end

