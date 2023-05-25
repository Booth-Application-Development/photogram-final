# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#

class Comment < ApplicationRecord
  validates(:commenter, {:presence => true })
  validates(:photo, {:presence => true })

   def commenter
    return User.where({ :id => self.author_id }).at(0)
    matching_users = User.where({ :id => my_author_id })

    the_user = matching_users.at(0)

    return the_user

  end

  def photo
    return Photo.where({ :id => self.photo_id }).at(0)
  end
end
