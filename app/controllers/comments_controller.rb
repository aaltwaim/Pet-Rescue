class CommentsController < ApplicationController
    before_action :check_if_owner, only: [:edit, :update, :destroy]

def new
    @comment = Comment.new
end
def create
    comment = Comment.create(params.require(:comment).permit(:content, :report_id))
    comment.user_id = current_user.id
    comment.save
    redirect_to request.referer
end
def show
    @comment = Comment.find(params[:id])
end
def edit
    @comment = Comment.find(params[:id])
end
def update
    comment = Comment.find(params[:id])
    comment.update(params.require(:comment).permit(:content))
    redirect_to report_path(comment.report)
  end
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private
    
      def check_if_owner
        @comment = Comment.find(params[:id])
        if current_user.id != @comment.user_id
        redirect_to @report
        end
      end
end
