class PostImagesController < ApplicationController
#画像投稿
  def new
    @post_image = PostImage.new
    #@post_imageにはform_withに渡すための「空のモデル」を代入する。
  end

#投稿データの保存
  def create
    #↓@post_imageは、PostImageによって生成された"PostImageの空のモデル"
    @post_image = PostImage.new(post_image_params)
    #↑post_image_params=フォームで入力されたデータが、投稿データとして許可されているパラメーターかどうかをチェックしてる。
    #↑投稿するデータをPostImageモデルに紐づくデータとして保存する準備をしている。
    #shop_nameやcaption,imageなどが@post_imageに格納されることになってる。
    @post_image.user_id = current_user.id #current_user=コードに記述するだけで、ログイン中のユーザーの情報を取得できる。
    #user_id="どのユーザーが投稿したのか"を"ユーザーのIDで判断する"ためのカラム。PostImageモデルに紐づいたuser_idの値を操作できる。
    #↑空のモデルは、"モデル名.カラム名"で繋げることで、保存するカラムの中身を操作することが出来る。
    #要約：@post_image（投稿データ）のuser_idを、current_user.id（今ログインしているユーザーのID）に指定することで、投稿データに今ログイン中のユーザーのIDを持たせることが出来る。という処理を行っている。
    if  @post_image.save #バリデーションの対象カラムにデータが保存された場合はsaveメソッドがtrueになってリダイレクト処理が行われる。
      redirect_to post_images_path
    else
      render :new #空白NG部分が空白だったらsaveメソッドがfalseになり、renderで新規投稿ページを再表示する。
      #redirect_to post_images_path
    end
  end

  def index
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  #投稿データのストロングパラメーター
private

def post_image_params
  params.require(:post_image).permit(:shop_name, :image, :caption)
end

end
