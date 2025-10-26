class BlogPostService

  def initialize(params = {}, headers = {})
    @params = params
    @headers = headers
  end

  # create_blog_post
  def create_blog_post
    user = current_user
    return { success: false, errors: ["Unauthorized: Admin access required!"] } unless user && user.flag == "Admin"
  end

  private
  def user_id_param
    headers = request.headers['Authorization']
    token = headers.split(' ').last
    decoded = JsonWebToken.new.decode_token(token)
    @user_id = decoded[:user_id]
  end
end