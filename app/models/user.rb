class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable,omniauth_providers: [:facebook, :google_oauth2]


  has_many :comments
  has_one :address
  # has_many :sns_credentials
  has_many :items
  has_one_attached :image
  has_many :likes
  has_many :liked_posts, through: :likes, source: :item

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人

  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy

  has_many :sns_credentials

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages

  def following?(user)
    following_user.include?(user)
  end

  #ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  #ユーザーのフォローを解除する
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end


  # いいね機能
  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end

  def create_notice_follow!(current_user)
    #すでに通知が作成されているか確認
    temp = Notice.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notice = current_user.active_notices.new(
        visited_id: id,
        action: 'follow'
      )
      notice.save if notice.valid?

    end
  end

  with_options presence: true do
    validates :nick_name
    validates :first_name
    validates :last_name
    validates :birthday
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])[a-z\d]{6,32}+\z/
  validates :password, presence: true, length: { minimum: 6, maximum: 32}, format: { with: VALID_PASSWORD_REGEX}


  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
  )
    # userが登録済みであるか判断
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns}
  end

end
