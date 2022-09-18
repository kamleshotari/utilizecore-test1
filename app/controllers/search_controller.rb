class SearchController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    if params[:search].present?
      @parcels = Parcel.where(guid: params[:search])
    else
      @parcels = []
    end
  end
end
