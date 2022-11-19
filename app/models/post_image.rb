class PostImage < ApplicationRecord

  belongs_to :user #所有されている関係。userに属する。
  has_one_attached :image
  has_many :post_comments,dependent: :destroy  #PostCmmentモデルを複数持つ。
  has_many :favorites, dependent: :destroy
  
  validates :shop_name, presence: true
  validates :image, presence: true
  

  def get_image #PostImageモデルの中に記述することで、メソッドを呼び出す。カラムの呼び出しと同じように。
    #if image.attached?
    #  image
    #else
    #  'no_image.jpg'
    #end

    #↓画像が設定されてない場合はapp/assets/imagesに格納されてる「no_image.jpg」という画像をデフォルト画像としてActiveStrageに格納し、表示する。というメソッド。
    unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io.File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

def favorited_by?(user)
  favorites.exists?(user_id: user.id)
end

end