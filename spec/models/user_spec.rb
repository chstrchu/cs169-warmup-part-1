require "rails_helper"

RSpec.describe User, :type => :model do
  it "stores users" do
    User.testAPI_resetFixture()
    num = User.add("neo", "pass")
    expect(num).to eq(1)  
  end
  
  it "ensures unique usernames" do
    User.testAPI_resetFixture()
    User.add("neo", "pass")
    num = User.add("neo", "pass2")
    expect(num).to eq(-2)
  end
  
  it "makes sure usernames aren't too long" do
    User.testAPI_resetFixture()
    num = User.add("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "pass")
    expect(num).to eq(-3)
  end
  
  it "makes sure usernames aren't empty" do 
    User.testAPI_resetFixture()
    num = User.add("", "pass")
    expect(num).to eq(-3)
  end
  
  it "makes sure passwords aren't too long" do
    User.testAPI_resetFixture()
    num = User.add("cipher", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    expect(num).to eq(-4)
  end
  
  it "makes sure usernames are valid before passwords" do
    User.testAPI_resetFixture()
    num = User.add("", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    expect(num).to eq(-3)
  end
  
  it "makes sure passwords can be empty" do
    User.testAPI_resetFixture()
    num = User.add("morpheus", "")
    expect(num).to eq(1)
  end
  
  it "makes sure invalid users cannot login" do
    User.testAPI_resetFixture()
    num = User.login("smith", "mr.anderson")
    expect(num).to eq(-1)
  end
  
  it "makes sure valid users can login" do
    User.testAPI_resetFixture()
    User.add("neo", "theone")
    num = User.login("neo", "theone")
    expect(num).to eq(2)
  end
  
  it "counts how many times a user logs in" do 
    User.testAPI_resetFixture()
    User.add("trinity", "pass")
    i = 0
    num = 0
    while i < 10
      num = User.login("trinity", "pass")
      i = i + 1
    end
    expect(num).to eq(11)
  end
    
end
