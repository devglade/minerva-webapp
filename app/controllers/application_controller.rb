class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  rescue_from User::NotAuthorized, with: :access_denied

  def access_denied(exception)
    @message = exception.message
    respond_to do |format|
      format.html {render 'errors/access_denied', status: :unauthorized, layout: 'error'}
      format.js {render 'errors/access_denied'}
    end
  rescue ActionController::UnknownFormat
    render status: :unauthorized, nothing: true
  end
end
