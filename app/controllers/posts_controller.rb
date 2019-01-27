class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project_spin
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :move]

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    if @space.is_public
      raise User::NotAuthorized, '초대받은 사람만 작성할 수 있습니다.' unless @space.isAllowed current_user.id
    end
    @post = @spin.posts.build(post_params)

    respond_to do |format|
      if @post.save
        ActionCable.server.broadcast "board", {commit: 'addPost', payload: render_to_string(:show, format: :json)}
        format.html {redirect_to space_project_spin_path(@space, @project, @spin)}
        format.json {render json: @post.to_json(include: :user), status: :created}
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
        ActionCable.server.broadcast "board", {commit: 'editPost', payload: render_to_string(:show, format: :json)}

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
      ActionCable.server.broadcast "board", {commit: 'destroyPost', payload: "{\"spin_id\":#{@spin.id},\"section_id\":#{@section.id},\"id\":#{@post.id}}"}
      format.html {redirect_to space_project_spin_path @space, @project, @spin, notice: 'Section was successfully destroyed'}
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
    broadcast_upvote_downvote(@post)
  end

  def downvote
    raise User::NotAuthorized, '자신이 쓴 글에는 싫어요를 할 수 없습니다.' unless @post.votable_by?(current_user)
    if current_user.voted_down_on? @post
      @post.unvote_by current_user
    else
      @post.downvote_by current_user
    end
    broadcast_upvote_downvote(@post)
  end

  def move
    user = Post.find(params[:id]).user
    data = params.require(:post).permit(:content, :position).merge(user: user,
                                                                   section_id: params[:section_id], spin_id: params[:spin_id])
    @post.update(data)
    ActionCable.server.broadcast "board", {commit: 'movePost', payload: render_to_string(:show, format: :json)}
    render action: :show
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

  def broadcast_upvote_downvote(post)
    ActionCable.server.broadcast "board", {commit: 'upVoteDownVoteUpdate', payload: "{\"spin_id\":#{@spin.id},
\"section_id\":#{@section.id},\"id\":#{post.id}, \"upvote_count\":#{post.get_upvotes.size}, \"downvote_count\":#{post.get_downvotes.size}}"}
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
