class UsersController < ApplicationController
  before_action :authenticate_user!

  def finish_signup
    if request.patch? && params[:user] #&& params[:user][:email]
      if current_user.update(user_params)
        current_user.skip_reconfirmation!
        sign_in(current_user, :bypass => true)
        redirect_to edit_user_registration_path(current_user), notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  def update_image
    if params[:image_id].present?
      begin
        preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
        fail 'Invalid upload signature' unless preloaded.valid?
        current_user.image_id = preloaded.public_id
      rescue
        current_user.image_id = params[:image_id]
      end
      current_user.save!
      Cloudinary::Uploader.remove_tag 'temporary', [current_user.image_id]
    end

    if flash[:first]
      redirect_to survey_answers_url
      return
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [:name, :email] # extend with your own params
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end