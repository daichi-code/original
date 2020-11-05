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

  has_many :following_relationships,foreign_key: "follower_id", class_name: "FollowRelationship",  dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships,foreign_key: "following_id",class_name: "FollowRelationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy

  def following?(other_user)
    self.followings.include?(other_user)
  end

  #ユーザーをフォローする
  def follow(other_user)
    self.following_relationships.create(following_id: other_user.id)
  end

  #ユーザーのフォローを解除する
  def unfollow(other_user)
    self.following_relationships.find_by(following_id: other_user.id).destroy
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
