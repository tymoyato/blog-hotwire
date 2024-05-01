# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!, unless: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def change_locale
    if params[:locale] == 'en'
      url = request.referer.gsub('/en', '/fr')
    elsif params[:locale] == 'fr'
      url = request.referer.gsub('/fr', '/en')
    end
    redirect_to url
  end
end
