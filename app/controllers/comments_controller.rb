class CommentsController < ApplicationController
    # before_acton :authenticate_user!

    def create
        @user=current_user
        @company=Company.find(params[:company_id])
        @comment=@company.comments.create(comment_params)
        if @comment.save
            render json: @comment, message: "comment added to company"
        else
            render json: @comment.errors
        end
        
    end

    private
    def comment_params
        params.require(:comment).permit(:comment,:user_id)
    end
end
