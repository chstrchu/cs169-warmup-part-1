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
      #name = User.find_by user: user
      if User.find_by user: user != nil
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
    string_output = output.to_s
    array = string_output.split(/\n/)
    i = 0
    while i < array.length
       if (/[123456789][0123456789] examples\, [123456789][0123456789] failures/ =~ array[i]) != nil or (/[012456789] examples\, [0123456789] [failures failure]/ =~ array[i]) != nil
         target_string = array[i]
       end
      i = i + 1
    end
    new_string = target_string.strip.split(/\s+/)
    target_example = new_string[0].to_i
    target_failure = new_string[2].to_i
    return [target_failure, string_output, target_example]
  end 








end
