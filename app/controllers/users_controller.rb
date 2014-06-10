class UsersController < InheritedResources::Base
  before_filter :authenticate_user!, only: :show
  respond_to :html
end
