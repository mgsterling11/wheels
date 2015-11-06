class User < ActiveRecord::Base
  has_many :user_trips

   def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end

  def self.find_by_provider_and_uid(auth)
    User.find_by(provider: auth[:provider], uid: auth[:uid])
  end

end