class Api::V1::BlogPostsController < ApplicationController

  # create_blog_post
  def create_blog_post
    begin
      
    rescue => e
      render json: { errors: "Something went wrong!", message: e.message }, status: :internal_server_error
    end
    
  end

  # privately hold blog_post_params
  private
  def blog_post_params
    params.require(:blog_post).permit(:user_id, :title, :excerpt, :content, :image_url)
  end
end
