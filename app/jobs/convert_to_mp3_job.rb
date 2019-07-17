class ConvertToMp3Job < ApplicationJob
  queue_as :default

  def perform(recording_id)
    # Do something later
    @recording = Recording.find(recording_id)

    if @recording.convertable?
      save_audio_file_to_tmp
      convert
      notify
    end
  end

  private
    def audio_file_path
      "#{Dir.tmpdir}/#{@recording.audio_file.filename}"
    end

    def new_audio_file_path
      audio_file_path + ".mp3"
    end

    def save_audio_file_to_tmp
      File.open(audio_file_path, 'wb') do |file|
        file.write(@recording.audio_file.download)
      end   
    end

    def convert
      audio = FFMPEG::Movie.new(audio_file_path)
      audio = audio.transcode(new_audio_file_path)

      @recording.audio_file.attach(io: File.open(new_audio_file_path), filename: new_audio_file_path)
      
      @recording.duration = audio.duration.to_i
      @recording.save
    end

    def notify
      #TODO: Notify
    end
end