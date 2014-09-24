class User < ActiveRecord::Base
  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2
  ERR_BAD_USERNAME = -3
  ERR_BAD_PASSWORD = -4
  validates :user, presence: true,
                    length: { maximum: 128 }
  validates :password, length: { maximum: 128 }
  
  def self.add(user, password)
      user = User.new(user: user, password: password, count: 1)
      name = User.find_by user: user
      if name != nil
        ERR_BAD_USERNAME
      elsif user.length > 128 or user == ''
        {errCode: ERR_BAD_USERNAME}
      elsif password.length > 128
        {errCode: ERR_BAD_PASSWORD}
      else
        user.save    
        return 1
      end
  end 
  
  def self.login(user, password)
    user = User.find_by user: user
    if user == nil
      {errCode: ERR_BAD_CREDENTIALS}
    else
      user.count = user.count + 1
      user.save
      {errCode: SUCCESS, count: user.count}
    end
  end
  
  def testAPI_resetFixture()
    User.destroy_all()
    {errcode: SUCCESS}
  end
  
  
  
  








end
