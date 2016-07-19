class Admin::RoomsController < ApplicationController

  before_action :set_room, only: [:destroy]

  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to admin_path, notice: 'Room was successfully created.' }
      end
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Room was successfully destroyed.' }
    end
  end

  private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end

end
