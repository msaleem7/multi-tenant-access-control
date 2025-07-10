# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :parental_consent, acceptance: true

  #associations
  has_many :memberships, dependent: :destroy
  has_many :user_spaces, dependent: :destroy
  has_many :spaces, through: :user_spaces
end
