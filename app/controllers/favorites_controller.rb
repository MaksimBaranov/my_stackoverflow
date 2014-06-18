class FavoritesController < InheritedResources::Base
  respond_to :html
  actions :favor
  before_filter :authenticate_user!
  belongs_to :answer, :question, polymorphic: true
  load_and_authorize_resource

  def favor
    resource = Favorite.new
    resource.user = current_user
    resource.favoriteable = parent
    resource.save
    redirect_to :back, notice: "You have added #{parent.class.to_s.downcase} to favorites."
  end
end
