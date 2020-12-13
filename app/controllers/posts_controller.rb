class PostsController < ApplicationController
  before_action :session_required, only: [:create, :edit, :update]
  before_action :set_board, only: [:new, :create]
  before_action :set_post, only: [:show]

  def show
    @comment = Comment.new
    # @comments = @post.comments.order(id: :desc).includes(:user) 
     @comments = @post.comments.includes(:user).page(params[:page]).per(5)

    #  <%# 套件 kaminari的分頁指令 %>

  end
  
  # includes會幫你把句子子改成 in 的寫法，就從N+1變成1+1
  # select *from posts where id = 7
  # select *from users where id in (3,5,8)
  
  # select *from user
   # @comments = @post.comments.where(deleted_at: nil).order(id: :desc).includes(:user)
    #includes是要避免n+1，
    # deleted_at: nil假刪除做法

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.board = @board

    if @post.save
      redirect_to @board, notice: '新增文章成功'
    else
      render :new
    end
  end


  def edit
    # @post = Post.find_by!(id: params[:id], user: current_user)
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: '文章更新成功'
    else
      render :edit
    end
  end

  def favorite
    post = Post.find(params[:id])

    if current_user.favorite?(post)
      # 移除我的最愛
      current_user.my_favorites.destroy(post)
      render json: { status: 'removed' }
    else
      # 加到我最愛
      current_user.my_favorites << post
      render json: { status: 'added' }
    end
  end



  private
  def set_board
    @board = Board.find(params[:board_id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
    # 原來是在show那行的指令
  end
end


    
    # @post = Post.new(post_params)
    # @post.board = @board
    # @post.user = current_user

    # @post = @board.posts.new(post_params)
    # @post.user = current_user
    # session_required寫在ApplicationController
