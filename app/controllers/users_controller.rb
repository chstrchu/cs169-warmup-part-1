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
    num = User.add(params[:user], params[:password])
    if num > 0
      render json: {errCode: User::SUCCESS, count: num}
    else
      render json: {errCode: num}
    end 
  end
  
 
  def login
    num = User.login(params[:user], params[:password]) 
    if num > 0
      render json: {errCode: User::SUCCESS, count: num}
    else
      render json: {errCode: num}
    end
  end
  
  def testAPI_resetFixture
    num = User.testAPI_resetFixture()
    render json: {errCode: num}
  end 
  
  def testAPI_unitTests
    output = User.testAPI_unitTests()
    render json:  {nrFailed: output[0], output: output[1], totalTests: output[2]}
  end
  
end

