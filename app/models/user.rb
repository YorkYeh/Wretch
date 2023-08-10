# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    before_create :encrypt_password
    
    has_many :articles
    has_many :comments
    has_many :albums
    has_many :orders
    
    has_many :like_logs
    has_many :liked_articles, through: :like_logs, source: :article

    validates :password, confirmation: true
    validates :email, presence: true, 
                      uniqueness: true, 
                      format: { 
                        with: URI::MailTo::EMAIL_REGEXP, 
                        message: '格式有誤' 
                      }


    def liked?(record)
      liked_articles.include?(record)
    end

    def unliked!(record)
      liked_articles.destroy(record)
    end

    def like!(record)
      liked_articles << record
    end

    def display_name
      if self.name.present?
        self.name
      else
        self.email.split("@").first.capitalize
      end
    end

    def self.login(email, password)

      return nil if email.empty? or password.empty?

      password = "x#{password}y".reverse
      password = Digest::SHA1.hexdigest(password)

      find_by(email: email, password: password)

    end


    private
    def encrypt_password
        pw = "x#{self.password}y".reverse
        self.password = Digest::SHA1.hexdigest(pw)
    end
end
