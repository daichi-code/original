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
  has_many :likes
  has_many :liked_posts, through: :likes, source: :item

  # フォロー取得
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy

  # フォロワー取得
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy

  # 自分がフォローしている人
  has_many :following_user, through: :follower, source: :followed

  # 自分をフォローしている人（フォロワー）
  has_many :follower_user, through: :followed, source: :follower


  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォロー確認を行う
  def following?(user)
    following_user.include?(user)
  end

  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end

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
