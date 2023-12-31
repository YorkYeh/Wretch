# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  password    :string
#  user_id     :integer          not null
#  deleted_at  :string
#  online      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Album < ApplicationRecord
  acts_as_list

  belongs_to :user
  validates :name,presence: true

  # has_many_attached :photos

  has_many_attached :photos do |attachable|
    attachable.variant :small, resize_to_limit: [100, 100]
  end

end
