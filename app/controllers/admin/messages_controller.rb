class Admin::MessagesController < ApplicationController
  before_action :set_room, only: [:destroy_all]

  def destroy_all
    Message.destroy_all(room_id:@room.id)
    respond_to do |format|
      format.html { redirect_to admin_url, notice: 'Messages was successfully destroyed.' }
    end
  end

  private

    def set_room
      @room = Room.find(params[:room_id])
    end

end
