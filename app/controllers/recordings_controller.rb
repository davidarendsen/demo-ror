class RecordingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_recording, only: [:show, :edit, :update, :destroy]

  def index
    @recordings = Recording.all
  end

  def show
  end

  def new
    @recording = Recording.new
  end

  def create
    @recording = Recording.create(recording_params)
    
    if @recording.valid?
      flash[:success] = "Added recording"
      redirect_to recordings_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recording.update(recording_params)
      flash[:success] = "Updated recording"
      redirect_to recording_path(Current.band, @recording)
    else
      flash[:alert] = "Could not update recording."
      render 'edit'
    end
  end

  private
    def set_recording
      @recording = Recording.find(params[:id])
    end

    def recording_params
      defaults = { }
      params.require(:recording).permit(:title, :audio_file).reverse_merge(defaults)
    end
end
