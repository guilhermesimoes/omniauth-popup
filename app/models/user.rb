class User < ActiveRecord::Base
  def self.find_or_create_with_omniauth(auth)
    user = User.find_by(:provider => auth.provider, :uid => auth.uid)
    if user
      user.update_info(auth)
    else
      create_with_omniauth(auth)
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
    end
  end

  def update_info(auth)
    self.image = auth.info.image if auth.info.image?
    self.save!
    self
  end
end
