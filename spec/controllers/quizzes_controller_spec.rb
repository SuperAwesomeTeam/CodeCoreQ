require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }

  describe "#new" do
    context "user signed in" do
      before { log_in(user) }
      before { get :new }

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "set a instance variable to a new quiz" do
        expect(assigns(:quiz)).to be_a_new Quiz
      end
    end

    context "user not signed in" do
      before { get :new }
      it "redirects to sign in page" do
        expect(response).to redirect_to login_path
      end
    end
  end
end