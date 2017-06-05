class Idea < ApplicationRecord

  has_many :reviews
  belongs_to :user, optional: true

  validates(:title, {presence: true, uniqueness: true})
  validates(:body, {length: {minimum: 1, maximum: 1000}})


  before_validation :titleize_title


  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

    private

    def titleize_title
      self.title = title.titleize if title.present?
    end

end
