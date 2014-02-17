class SiteController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:kevin]

  def index
  end

  def kevin

  end

  def allen

  end

  def addUserInfo

  end

  def save_adduserinfo

  end

  def NeedsModal

  end

  def PrioritiesModal

  end

  def ProviderModal

  end

  def RecommendationModal

  end
end
