class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:kevin]

  def index
  end

  def kevin

  end

  def addUserInfo

  end

  def save_adduserinfo

  end
end
