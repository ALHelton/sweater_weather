require "rails_helper"

RSpec.describe User do
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
		it { should validate_presence_of :password }
  end

  describe "instance methods" do
    let(:user) { User.new(email: "hello@hello.com", password: "123") }

    it "create_key" do
      expect(user.api_key).to eq(nil)

      user.create_key
      expect(user.api_key.length).to eq(26)
      expect(user.api_key).to_not eq(nil)
    end
  end
end