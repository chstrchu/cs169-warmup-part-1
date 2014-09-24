require "rails_helper"

RSpec.describe User, :type => :model do
  it "stores users" do
    num = User.add("neo", "pass")
    
    expect(num).to eq(1)
    
  end
end
