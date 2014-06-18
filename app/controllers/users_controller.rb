class UsersController < InheritedResources::Base
  before_filter :authenticate_user!, except: [:show, :index]
  respond_to :html
end
