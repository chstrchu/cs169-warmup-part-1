class User < ActiveRecord::Base
  SUCCESS = 1
  ERR_BAD_CREDENTIALS = -1
  ERR_USER_EXISTS = -2
  ERR_BAD_USERNAME = -3
  ERR_BAD_PASSWORD = -4
  validates :user, presence: true,
                    length: { maximum: 128 }
  validates :password, length: { maximum: 128 }
  
  def add()
      a = self.user
      b = self.password
      user = User.new(user: a, password: b, count: 1)
      name = User.find_by user: a
      
      if name != nil
        print ERR_USER_EXISTS
        return ERR_USER_EXISTS
      end
      if a.length > 128 or a == nil
        print ERR_BAD_USERNAME
        return ERR_BAD_USERNAME
      end
      if b.length > 128
        print ERR_BAD_PASSWORD
        return ERR_BAD_PASSWORD
      else
        user.save
        print SUCCESS
        return SUCCESS
      end
  end 
  
  def login()
    a = self.user
    b = self.password
    user = User.find_by user: a
    if user == nil
      print ERR_BAD_CREDENTIALS
      return ERR_BAD_CREDENTIALS
    else
      user.count = user.count + 1
      user.save
      print user.count
      return user.count
    end
  end
  
  def testAPI_resetFixture()
    User.destroy_all()
    return SUCCESS
  end
  
  
  
  








end
