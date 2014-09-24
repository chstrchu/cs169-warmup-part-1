require "rails_helper"

RSpec.describe User, :type => :model do
  it "stores users" do
    user = User.new(user: "neo", password: "pass")
    
    expect(user.add()).to eq([1, 1])
    
  end
end
