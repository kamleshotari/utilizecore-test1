class SearchController < ApplicationController
  def index
    if params[:search].present?
      @parcels = Parcel.where(guid: params[:search])
    else
      @parcels = []
    end
  end
end
