require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user)     { create(:user) }
  let(:quiz)     { create(:quiz) }
  let(:question) { create(:question, quiz: quiz) }
  let(:answer)   { create(:answer, question: question) }
  let(:answer_1) { create(:answer, question: question) }

  describe "#new" do
    context "user signed in" do
      before { log_in(user) }
      before { get :new, question_id: question.id }

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "set a instance variable to question" do
        expect(assigns(:question)).to eq(question)
      end
    end

    context "user not signed in" do
      before { get :new, question_id: question.id }

      it "redirects to sign in page" do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#index" do
    context "user signed in" do
      before { log_in(user) }
      before { get :index, question_id: question.id }

      it "renders the index template" do
        expect(response).to render_template(:index)
      end

      it "set a instance variable to question" do
        expect(assigns(:question)).to eq(question)
      end

      it "set a instance variable to for question answers" do
        answer
        answer_1
        expect(assigns(:answers)).to eq([answer, answer_1])
      end
    end

    context "user not signed in" do
      before { get :index, question_id: question.id }

      it "redirects to sign in page" do
        expect(response).to redirect_to login_path
      end
    end
  end
end