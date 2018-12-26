class ApplicationController < ActionController::Base
	before_action :authenticate_user!, only: [:show, :edit, :new, :index]
	# before_actionで指定されたメソッドは、このコントローラが実行される前に実行される(最初に実行される)
	# authenticate_user!はdeviseで用意されているメソッドで、ログインされていなければrootパスへリダイレクトする機能を実装できる

	before_action :configure_permitted_parameters, if: :devise_controller?
	# deviseを利用する機能（ユーザ登録、ログイン認証など）が実行される前に、configure_permitted_parametersが実行される(protectedより下の部分)

	def after_sign_in_path_for(resource)
		user_path(current_user.id)
		# サインイン後のリダイレクト先を指定(redirect_toは記載しない)
	end

	def after_sign_out_path_for(resource)
		users_top_path
		# サインアウト後のリダイレクト先を指定
	end

	def after_sign_up_path_for(resource)
		user_path(current_user.id)
		# 新規登録後のリダイレクト先を設定
	end

	protected

  	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
		# configure_permitted_parametersでは、devise_parameter_sanitizer.permitでnameのデータ操作を許可するアクションメソッドが指定されている。
		# 今回の場合、ユーザ登録(sign_up)の際、ユーザ名(name)のデータ操作が許可されることになる。
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])

  	end

end
