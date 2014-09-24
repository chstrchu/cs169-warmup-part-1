require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def test_user
    one = User.new :user => users(:one).user,
                   :password => users(:one).password,
                   :count => users(:one).count
    assert one.save
    
    one_copy = User.find(one.id)
    assert_equal one.user, one_copy.user
    
    one.user = "neo"
    assert one.save
    assert one.destroy
  end
end
