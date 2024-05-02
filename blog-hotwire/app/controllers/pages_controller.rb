class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home test]

  def home
  end

  def test
    puts 'TESSSSSSSSSSSSSSSSSSSSST'
  end
end
