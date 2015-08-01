require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "instantiates a new user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

end