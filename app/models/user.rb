class User < ActiveRecord::Base
    validates :email, presence: true
    has_many :groups, dependent: :destroy
end