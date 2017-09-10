class Api::V2::RoomsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
    render json:@rooms
  end

end
