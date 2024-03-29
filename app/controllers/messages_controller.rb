class MessagesController < ApplicationController
	before_action :authenticate_user!, except: [:undelivered, :update, :create]
	before_action :set_message, only: [:show, :edit, :update, :destroy]
	skip_before_action :verify_authenticity_token

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

	def undelivered
    	@messages = Message.where(sent: true, delivered: false)
	end	
	
  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
	@message = Message.new(message_params)
	@buddy = Buddy.find_or_create_by(buddyid: @message.buddyid)
	@message.buddy_id = @buddy.id
	@buddy.update(fullname: @message.fullname) if (@buddy.fullname.blank? && !@message.fullname.blank?)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @buddy, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :fullname, :buddyid, :sent, :received, :delivered, :buddy_id)
    end
end
