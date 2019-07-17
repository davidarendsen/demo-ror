class HomeController < ApplicationController
  def index
    @recordings = Recording.limit(5)
  end

  def terms
  end

  def privacy
  end
end
