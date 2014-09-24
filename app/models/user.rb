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
      user_object = User.new(user: user, password: password, count: 1)
      name = User.find_by user: user
      if name != nil
        ERR_USER_EXISTS
      elsif user.length > 128 or user == ''
        ERR_BAD_USERNAME
      elsif password.length > 128
        ERR_BAD_PASSWORD
      else
        user_object.save    
        return user_object.count
      end
  end 
  
  def self.login(user, password)
    user_object = User.find_by user: user
    if user_object == nil
      ERR_BAD_CREDENTIALS
    else
      user_object.count = user_object.count + 1
      user_object.save
      return user_object.count
    end
  end
  
  def self.testAPI_resetFixture()
    User.destroy_all()
    SUCCESS
  end
  
  
  def self.testAPI_unitTests()
    %x(rspec > test_result)
    output = %x(cat test_result)
    return output
  end 








end
