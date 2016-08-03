class UserIdentity < ApplicationRecord
  VALID_PROVIDERS = ['twitter']

  belongs_to :user

  validates :provider, presence: true, inclusion: { in: VALID_PROVIDERS }
  validates :provider_user_id, uniqueness: {scope: :provider}, presence: true
  validates :user, presence: true

  ###
  ### Twitter
  def self.find_or_create_by_twitter(auth)
    identity = find_by(provider_user_id: auth.uid, provider: 'twitter')
    if identity
      # Refresh credentials/info on every authorization and also
      # to pickup missing tokens.
      identity.provider_user_id = auth.uid
      identity.username = auth.info.nickname
      identity.access_token = auth.credentials.token

      if identity.changed?
        identity.save!
      end

      return identity
    end

    user = User.new
    user.name = auth.info.name
    user.avatar_url = auth.info.image
    user.save!

    identity = user.identities.new
    identity.provider = 'twitter'
    identity.provider_user_id = auth.uid
    identity.username = auth.info.nickname
    identity.access_token = auth.credentials.token
    identity.save!

    identity
  end
end
