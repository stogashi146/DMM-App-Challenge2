class BooksController < ApplicationController
  before_action :ensure_current_user,only:[:edit,:update]
  before_action :ensure_current_user,only:[:edit,:update]
  def ensure_current_user
    @book = Book.find(params[:id])
    unless current_user.id == @book.user_id
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new

  end

  def index
    @favorite = Favorite.new
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    Book.find(params[:id]).destroy
    redirect_to books_path
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def delete
    @book = Book.find(params[:id])
    @book.destoy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
