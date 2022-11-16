class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?
#↑ユーザー登録・ログイン認証が行われる前にconfigure~メソッドが実行される。

#サインイン・アウト後の遷移先はルートパスがデフォルト。それを変更するのが↓
 def after_sign_in_path_for(resource) #サインイン後にどこに遷移するか設定してるメソッド
   post_images_path
 end

def after_sign_out_path_for(resource)
  about_path
end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end

#befor_action :configure_permitted_parameters, if: :devise_controller?