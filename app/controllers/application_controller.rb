class ApplicationController < ActionController::Base
  before_action :set_locale, :ensure_signup_complete, only: [:new, :create, :update, :destroy]
  protect_from_forgery prepend: true

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || :ko
  end
end
