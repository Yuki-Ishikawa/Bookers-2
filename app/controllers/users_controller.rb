class UsersController < ApplicationController
  def top
  end

  def about
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
  	@books = @user.books.page(params[:page]).reverse_order
  end

  def edit
   	@user = User.find(params[:id])
    # リンク先"edit_user_path"
    if @user.id == current_user.id

    else
      redirect_to user_path(@user.id)
    end
  end

  def index
    @users = User.all
    @book = Book.new
    @user = User.find(current_user.id)
    # "render"でビューを転送するときでも転送元に記載のある変数などを記載しないといけない(render単品で全てを持ってくることは不可)
  end

  def update
  	@user = User.find(params[:id])
    # IDを元にUserモデルから検索
    if @user.update(user_params)
      # 更新処理
      redirect_to user_path(@user.id)
      # ユーザーページにリダイレクト
    else
      render :edit
    end
  end

  private

  def user_params
 	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
