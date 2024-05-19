# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: %i[set_locale change_locale]
  check_authorization except: %i[set_locale change_locale], unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def set_locale
    return unless I18n.available_locales.include?(params[:locale].to_sym)

    I18n.locale = params[:locale].to_sym || I18n.default_locale
  end

  def change_locale
    if I18n.locale == :en
      url = request.referer.gsub('/en', '/fr')
      I18n.locale = :fr
    elsif I18n.locale == :fr
      url = request.referer.gsub('/fr', '/en')
      I18n.locale = :en
    end
    redirect_to url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
