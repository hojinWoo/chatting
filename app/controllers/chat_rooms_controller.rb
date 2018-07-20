class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :edit, :update, :destroy, :join, :chat]

  # GET /chat_rooms
  # GET /chat_rooms.json
  def index
    @chat_rooms = ChatRoom.all
  end

  # GET /chat_rooms/1
  # GET /chat_rooms/1.json
  def show
  end

  # GET /chat_rooms/new
  def new
    @chat_room = ChatRoom.new
  end

  # GET /chat_rooms/1/edit
  def edit
  end

  # POST /chat_rooms
  # POST /chat_rooms.json
  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.master_id = current_user.email
    respond_to do |format|
      if @chat_room.save
        Admission.create(user_id: current_user.id, chat_room_id: @chat_room.id)
        format.html { redirect_to @chat_room, notice: 'Chat room was successfully created.' }
        format.json { render :show, status: :created, location: @chat_room }
      else
        format.html { render :new }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chat_rooms/1
  # PATCH/PUT /chat_rooms/1.json
  def update
    respond_to do |format|
      if @chat_room.update(chat_room_params)
        format.html { redirect_to @chat_room, notice: 'Chat room was successfully updated.' }
        format.json { render :show, status: :ok, location: @chat_room }
      else
        format.html { render :edit }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_rooms/1
  # DELETE /chat_rooms/1.json
  def destroy
    @chat_room.destroy
    respond_to do |format|
      format.html { redirect_to chat_rooms_url, notice: 'Chat room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # user join too
  def join
    unless current_user.join_room?(@chat_room)
      Admission.create(user_id: current_user.id, chat_room_id: params[:id])
    else
      render js: "alert('이미 참여한 방입니다.')"
    end
  end

  #채팅 받아서 처리
  def chat
    # @chat_room -> chat
    @chat_room.chats.create(user_id: current_user.id, message: params[:message])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_room_params
      params.require(:chat_room).permit(:title, :master_id, :max_count, :admission_count)
    end
end
