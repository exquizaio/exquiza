# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  middle_name            :string
#  grade                  :integer
#  school                 :string
#  tests_id               :integer
#  admin                  :boolean          default("f")
#  correct                :boolean
#

class User < ActiveRecord::Base
  has_paper_trail

  has_many :tests, inverse_of: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable, :registerable


  def can_view_report?(a_test)
    a_test.finished? and (a_test.user == self or admin?)
  end

  def can_download_report?(a_test)
    can_view_report?(a_test) and admin?
  end

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end

end
