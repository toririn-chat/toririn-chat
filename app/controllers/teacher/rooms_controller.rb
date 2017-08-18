class Teacher::RoomsController < ApplicationController


  before_action :authenticate_user!
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
    @rooms = Room.where(teacher_id:current_user.id)
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    p current_user
    @room.teacher = current_user
    if @room.save
      redirect_to teacher_rooms_path, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to teacher_path, notice: 'Room was successfully destroyed.' }
    end
  end

  private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name, :teacher_id)
    end

end
