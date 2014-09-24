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
      print name
      if name != nil
        print "in loop"
        {errCode: ERR_USER_EXISTS}
      elsif a.length > 128 or a == ''
        {errCode: ERR_BAD_USERNAME}
      elsif b.length > 128
        {errCode: ERR_BAD_PASSWORD}
      else
        user.save    
        {errCode: SUCCESS, count: 1}
      end
  end 
  
  def login()
    a = self.user
    b = self.password
    user = User.find_by user: a
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
