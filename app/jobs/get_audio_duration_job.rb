class GetAudioDurationJob < ApplicationJob
  queue_as :default

  def perform(recording_id)
    # Do something later
    @recording = Recording.find(recording_id)

    if @recording.audio_file.audio?
      save_audio_file_to_tmp
      get_duration
    end
  end

  private
    def save_audio_file_to_tmp
      File.open(audio_file_path, 'wb') do |file|
        file.write(@recording.audio_file.download)
      end   
    end

    def audio_file_path
      "#{Dir.tmpdir}/#{@recording.audio_file.filename}"
    end

    def get_duration
      audio = FFMPEG::Movie.new(audio_file_path)
      duration = audio.duration #duration in seconds

      @recording.duration = duration
      @recording.save
    end

end