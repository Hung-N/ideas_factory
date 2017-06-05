class Idea < ApplicationRecord

  belongs_to :user, optional: true

  validates(:title, {presence: true, uniqueness: true})
  validates(:body, {length: {minimum: 5, maximum: 1000}})
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  before_validation :titleize_title


  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

    private

    def titleize_title
      self.title = title.titleize if title.present?
    end

end
