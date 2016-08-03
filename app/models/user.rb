class User < ApplicationRecord
  devise :rememberable,
         :omniauthable,
         :omniauth_providers => UserIdentity::VALID_PROVIDERS

  has_many :identities, class_name: 'UserIdentity', dependent: :destroy
  has_many :indices
end
