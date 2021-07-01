class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


  with_options presence: true do
    validates :birth_date
    validates :nickname
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は日本語で記入してください' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'は日本語(カナ)で記入してください' } do
      validates :last_name_kana
      validates :first_name_kana
    end
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  end
  
  has_many :messages, dependent: :destroy
  has_many :items
  has_many :orders
  has_one :card, dependent: :destroy
  has_many :sns_credentials
  has_one :address

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create

    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
