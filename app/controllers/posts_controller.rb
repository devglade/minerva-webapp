class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_retrospect_spin
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(spin_id: params[:spin_id]).order('created_at DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @spin.posts.build(post_params)
    @post.save
    broadcast_create_post @post
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        broadcast_update_post(@post)
        format.json {render :show, status: :ok, location: @post}
        format.js {render js: '$(".modal").modal("hide");'}
      else
        format.html {render :edit}
        format.json {render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|

      broadcast_delete_post(@post)

      #format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json {head :no_content}
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user

    broadcast_like_dislike_post(@post)
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user

    broadcast_like_dislike_post(@post)
  end

  private
  def set_retrospect_spin
    @spin = Spin.find(params[:spin_id])
    @retrospect = Retrospect.find(@spin.retrospect.id)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    logger.debug params
    local_params = params.require(:post).permit(:content)
    local_params = local_params.merge(user: current_user)
    local_params = local_params.merge(spin_id: params[:spin_id])
    return local_params
  end

  def broadcast_like_dislike_post(post)
    ActionCable.server.broadcast "posts", {action: "like_dislike", id: "post-#{post.id}", like: "#{post.get_upvotes.size}", dislike: "#{post.get_downvotes.size}"}
  end

  def broadcast_create_post(post)
    html = ApplicationController.render partial: "posts/post", locals: {current_user: current_user, post: post}, formats: [:html]
    ActionCable.server.broadcast "posts", {action: "create", id: "post-#{post.id}", html: html}
  end

  def broadcast_delete_post(post)
    ActionCable.server.broadcast "posts", {action: "delete", id: "post-#{post.id}"}
  end

  def broadcast_update_post(post)
    html = ApplicationController.render partial: "posts/post", locals: {current_user: current_user, post: post}, formats: [:html]
    ActionCable.server.broadcast "posts", {action: "update", id: "post-#{post.id}", html: html}
  end
end
