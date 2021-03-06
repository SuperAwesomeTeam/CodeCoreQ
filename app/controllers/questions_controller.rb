class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
    # render text: params
    @quiz     = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.new
  end

  def create
    # render text: params
    @quiz     = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.new question_params

    if @question.save
      flash[:notice] = "Question created for #{@quiz.title}"
      redirect_to quiz_questions_path
    else
      flash[:alert] = "Could not create question."
      render :new
    end
  end

  def show
    # render text: params
    @quiz     = Quiz.find params[:quiz_id]
    @question = Question.find(params[:id])
    @answers  = @question.answers
  end

  def index
    @quiz      = Quiz.find params[:quiz_id]
    @questions = @quiz.questions.all
  end

  def edit
    @question = Question.find(params[:id])
    @quiz     = @question.quiz 
  end

  def update
    # render text: params
    @question = Question.find(params[:id])

    if @question.update question_params
      flash[:notice] = "Question updated"
      redirect_to quiz_questions_path(@question.quiz)
    else
      flash[:alert] = "Could not update question."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @quiz     = @question.quiz

    @question.destroy
    flash[:notice] = "Question deleted"
    redirect_to quiz_questions_path(@quiz)
  end

  private

  def question_params 
    params.require(:question).permit(:title, :body, :explanation, :quiz_id)
  end

end
