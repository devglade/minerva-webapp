class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_spin
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :move]

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

    respond_to do |format|
      if @post.save
        format.html {redirect_to space_project_spin_path(@space, @project, @spin)}
        format.json {render json: @post.to_json, status: :created}
      else
        format.html {render :new}
        format.json {render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    raise User::NotAuthorized, '수정할 권한이 없습니다.' unless @post.updatable_by?(current_user)
    respond_to do |format|
      if @post.update(post_params)
        format.html {redirect_to space_project_spin_path(@space, @project, @post), notice: 'Post was successfully updated.'}
        format.json {render json: @post.to_json, status: :ok}
      else
        format.html {render :edit}
        format.json {render json: @post.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    raise User::NotAuthorized, '삭제할 권한이 없습니다.' unless @post.updatable_by?(current_user)

    @post.destroy
    respond_to do |format|

      broadcast_delete_post(@post)

      #format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json {head :no_content}
    end
  end

  def upvote
    raise User::NotAuthorized, '자신이 쓴 글에는 좋아요를 할 수 없습니다.' unless @post.votable_by?(current_user)
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end
    broadcast_like_dislike_post(@post)
  end

  def downvote
    raise User::NotAuthorized, '자신이 쓴 글에는 싫어요를 할 수 없습니다.' unless @post.votable_by?(current_user)
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else
      @post.downvote_by current_user
    end
    broadcast_like_dislike_post(@post)
  end

  def move
    @post.update(post_params)
    render action: :index

  end

  private

  def set_project_spin
    @spin = Spin.find(params[:spin_id])
    @project = @spin.project
    @space = @project.space
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    @section = @post.section
    @spin = @post.spin
    @project = @spin.project
    @space = @project.space
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    logger.debug params
    params.require(:post).permit(:content, :position).merge(user: current_user,
                                                            section_id: params[:section_id], spin_id: params[:spin_id])
  end

  def broadcast_like_dislike_post(post)
    ActionCable.server.broadcast "#{post.spin.id}_posts", {action: "like_dislike", id: "post-#{post.id}", like: "#{post.get_upvotes.size}", dislike: "#{post.get_downvotes.size}"}
  end

  def broadcast_create_post(post)
    html = ApplicationController.render partial: "posts/post", locals: {current_user: current_user, post: post}, formats: [:html]
    ActionCable.server.broadcast "#{post.spin.id}_posts", {action: "create", id: "post-#{post.id}", spin_id: post.spin.id, html: html}
  end

  def broadcast_delete_post(post)
    ActionCable.server.broadcast "#{post.spin.id}_posts", {action: "delete", id: "post-#{post.id}"}
  end

  def broadcast_update_post(post)
    html = ApplicationController.render partial: "posts/post", locals: {current_user: current_user, post: post}, formats: [:html]
    ActionCable.server.broadcast "#{post.spin.id}_posts", {action: "update", id: "post-#{post.id}", html: html}
  end
end
