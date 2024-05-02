# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!, except: %i[set_locale change_locale]

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
end
