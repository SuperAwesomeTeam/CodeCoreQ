class Quiz < ActiveRecord::Base
  
  belongs_to :category
  has_many :questions, dependent: :destroy

  has_many :user_quizzes, dependent: :destroy
  has_many :users, through: :user_quizzes

  validates :title, presence: true, uniqueness: :true
  validates :body, presence: true
  validates :level, presence: true, numericality: true
  validates :category_id, presence: true, numericality: true

  def per_question_point
    q_count = questions.count
    if q_count != 0
      100 / q_count
    else
      0
    end
  end

end
