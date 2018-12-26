class BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    # current_user.id=現在のユーザーID
    @book.user_id = current_user.id
    # 181224 本行を削除したら"UrlGenerationError"発現(idの紐付けができていなかった?)
    # 181224 親子関係
    @books = Book.all
    @user = User.find(current_user.id)
    if @book.save
      # データベースへ保存
      redirect_to book_path(@book.id)
      # 詳細ページへリダイレクト
      flash[:notice] = "Book was successfully created."
      # リダイレクト後"notice"以下のメッセージを表示
    else
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    # IDを元にBookモデルを検索
    @bookf = Book.new
    # フォーム用
    @user = User.find(current_user.id)
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
    # "render"でビューを転送するときでも転送元に記載のある変数などを記載しないといけない(render単品で全てを持ってくることは不可)
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
  
    else
    redirect_to book_path(@book.id)
    end
  end

  def update
    @book = Book.find(params[:id])
    # IDを元にBookモデルを検索
    if @book.update(book_params)
      # 更新内容を保存
      redirect_to book_path(@book.id), notice: "Book was successfully updated."
      # 詳細ページへリダイレクト
      # リダイレクト後"notice"以下のメッセージを表示
    else
      render :edit
      # 変数"book"の状態でエラーに該当すると"No Method Error"発現、"@book"のすることで解決
      # "render"でeditに飛ばそうとするとeditを経由するのではなく直接飛ぶので@が必要となる
    end
  end

  def destroy
    book = Book.find(params[:id])
    # IDを元にBookモデルを検索
    book.destroy
    # データベースより削除
    redirect_to books_path
    # 一覧ページへリダイレクト
    flash[:notice] = "Book was successfully destroyed."
    # リダイレクト後"notice"以下のメッセージを表示
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :id)
  end

end
