require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }
  let(:all_categories) { 5.times { create(:category) } }

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

      it "set a instance variable to for all categories" do
        all_categories
        expect(assigns(:categories)).to eq(Category.all)
      end
    end

    context "user not signed in" do
      before { get :new }
      it "redirects to sign in page" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#create" do

    context "user signed in" do
      before { log_in(user) }

      context "with valid parameters" do
        def valid_request
          post :create,
            { 
              quiz: {
                title: "Remember the Titans",
                body: "Aint no mountain high enough",
                level: 10,
                category_id: 6
              }
            }
        end

        it "set a instance variable to for all categories" do
          all_categories
          valid_request
          expect(assigns(:categories)).to eq(Category.all)
        end

        it "creates a new quiz in the database" do
          expect { valid_request }.to change { Quiz.count }.by(1)
        end

        it "sets a flash message" do
          valid_request
          expect(flash[:success]).to be
        end

        it "redirect to quiz show page" do
          valid_request
          expect(response).to redirect_to(quiz_path(Quiz.last))
        end
      end

      context "with invalid parameters" do
        def invalid_request
          post :create, quiz: {title: "Lols Yo, Derp Derp"}
        end

        it "set a instance variable to for all categories" do
          all_categories
          invalid_request
          expect(assigns(:categories)).to eq(Category.all)
        end

        it "doesn't create a record in the database" do
          expect { invalid_request }.to change { Quiz.count }.by(0)
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end

        it "sets a flash message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end
  end
end
