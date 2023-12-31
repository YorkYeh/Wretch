# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sub_title  :string
#  user_id    :integer
#  password   :string
#
class Article < ApplicationRecord

    enum category: {kids: 0, adult: 1, oldman: 2}
    
    validates :title, presence: true
    belongs_to :user
    has_many :comments
    
    has_many :like_logs
    has_many :users, through: :like_logs

    def self.search(keyword)
        if keyword
            where("title LIKE '%#{keyword}%' OR content LIKE '%#{keyword}%'")
        else
            all
        end
    end
end
