class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo

  belongs_to :company, optional: true
  has_many :tasks, dependent: :nullify, foreign_key: :owner_id

  def belongs_to_company?
    company.present?
  end
end
