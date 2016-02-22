class Restaurant < ActiveRecord::Base
    validates :name, presence: true
    belongs_to :group
    has_and_belongs_to_many :events

    def url
        "/user/#{group.user.id}/group/#{group.id}/restaurant/#{id}"
    end
end