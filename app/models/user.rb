class User < ActiveRecord::Base
  def self.find_or_create_with_omniauth(auth)
    user = find_by(auth.slice(:provider, :uid)) || initialize_from_omniauth(auth)
    user.update_dynamic_attributes(auth)
  end

  def self.initialize_from_omniauth(auth)
    new do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
    end
  end

  def update_dynamic_attributes(auth)
    self.image = auth.info.image if auth.info.image?
    self.save!
    self
  end
end
