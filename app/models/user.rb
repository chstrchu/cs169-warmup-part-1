class User < ActiveRecord::Base
  validates :user, presence: true,
                    length: { maximum: 128 }
  validates :password, length: { maximum: 128 }
  
  
end
