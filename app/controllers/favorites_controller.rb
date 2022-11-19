class FavoritesController < ApplicationController

#いいね機能もコメント機能同様、index,newアクションは作成せず投稿画像詳細画面（/post_image/:id/）で実装する。

  def create
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.new(post_image_id: post_image.id)
    favorite.save
    redirect_to post_image_path(post_image)
  end
  #記事にいいねして保存された後はpost_imagesのshowページへリダイレクト

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
    redirect_to post_image_path(post_image)
  end

end
