require 'application_responder'
class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.json do
        render json: { error: t('cancancan.forbidden') }.to_json,
               status: :forbidden
      end
      format.js { head :forbidden }
    end
  end

  protected

  def gon_user
    gon.current_user_id = current_user ? current_user.id : 0
  end

  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation remember_me admin]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(_resource)
    root_path
  end
end
