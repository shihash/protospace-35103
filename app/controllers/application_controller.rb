class ApplicationController < ActionController::Base
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    Comment.create(comment_params)
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id,prototype_id: params[:prototype_id])
  end
end
