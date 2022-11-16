class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy

has_one_attached :profile_image
#↑profile_imageという名前で、ActiveStrageでプロフィール画像を保存できるように設定した。
def get_profile_image(width,height) #←indexで使えるようになるやつ
  unless profile_image.attached? then
    file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit:[width,height]).processed
  #↑画像のサイズ変更を行う。width,heightにすることで、どんなサイズにでも変更できるようになった。
end

end

