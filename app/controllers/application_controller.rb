class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :nav

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def nav(*path)
    @nav ||= Navigation.new(path)
  end

  class Navigation
    def initialize(path)
      @path = path.map(&:to_sym)
    end

    def method_missing(meth, *args, &blk)
      @path.include? meth.to_s[0..-2].to_sym
    end
  end

end
