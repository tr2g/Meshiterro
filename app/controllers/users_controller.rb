class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images #←アソシエーションを持ってるモデル同士の記述方法。
    #↑特定のユーザー(@user)に関連付けられた投稿全て(.post_images)を取得して@post_imagesに渡す。という処理ができる。
    #↑つまり、全体の投稿ではなく、個人が投稿したすべてのものを表示できる。
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
  end

private
def user_params
  params.require(:user).permit(:name,:profile_image)
end

end
