class BoardsController < ApplicationController
  before_action :find_board, only: [:show, :edit, :update, :destroy, :hide, :open, :lock]

  def index
    @boards = Board.all
  end

  def show
    @posts = @board.posts.order(id: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to "/", notice: '成功新增看板'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to root_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to root_path, notice: '看板已刪除'
  end

  def hide
    @board.hide! if @board.may_hide?
    redirect_to boards_path, notice: '看板己隱藏'
  end

  def open
    @board.open! if @board.may_open?
    redirect_to boards_path, notice: '看板己開放'
  end

  def lock
    @board.lock! if @board.may_lock?
    redirect_to boards_path, notice: '看板己鎖定'
  end

  private
  def find_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title)
  end




end


#以上是省略前的原版

#失敗會多包一層div，所以會跳行
# redirect_to '/'回到首頁

# 模組化寫法如下，定義find_board後，重複的抽出
# class BoardsController < ApplicationController
#   before_action :find_board, only: [:show, :edit, :update, :destroy]

#   def index
#     @boards = Board.all
#   end

#   def show
#   end

#   def new
#     @board = Board.new
#   end

#   def create
#     @board = Board.new(board_params)

#     if @board.save
#       redirect_to "/", notice: '成功新增看板'
#     else
#       render :new
#     end
#   end

#   def edit
#   end

#   def update
#     if @board.update(board_params)
#       redirect_to root_path, notice: '更新成功'
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @board.destroy
#     redirect_to root_path, notice: '看板已刪除'
#   end

#   private
#   def find_board
#     @board = Board.find(params[:id])
#   end

#   def board_params
#     params.require(:board).permit(:title)
#   end
# end