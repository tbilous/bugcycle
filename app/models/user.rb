class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories
  has_many :items
  has_many :black_lists, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :item_suggestions, class_name: 'Suggestion', foreign_key: :author_id

  def owner_of?(object)
    id == object.user_id
  end
end
