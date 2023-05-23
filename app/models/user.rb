# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  follow          :boolean
#  password_digest :string
#  private         :boolean          default(FALSE)
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
end
