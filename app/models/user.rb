class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :comments
  has_one :address
  # has_many :sns_credentials
  has_many :items
  has_one_attached :image

  with_options presence: true do
    validates :nick_name
    validates :first_name
    validates :last_name
    validates :birthday
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])[a-z\d]{6,32}+\z/
  validates :password, presence: true, length: { minimum: 6, maximum: 32}, format: { with: VALID_PASSWORD_REGEX}
  # def self.from_omniauth(auth)
  #   sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
  #   # sns認証したことがあればアソシエーションで取得
  #   # 無ければemailでユーザー検索して取得orビルド(保存はしない)
  #   user = User.where(email: auth.info.email).first_or_initialize(
  #     nickname: auth.info.name,
  #       email: auth.info.email
  # )
  #   # userが登録済みであるか判断
  #   if user.persisted?
  #     sns.user = user
  #     sns.save
  #   end
  #   { user: user, sns: sns}
  # end

end
