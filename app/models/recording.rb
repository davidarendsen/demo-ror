class Recording < ApplicationRecord
  has_one_attached :audio_file
  after_commit :convert_to_mp3
  after_commit :get_duration, on: :create

  validates :title, presence: true
  validate :correct_mime_type

  def convertable?
    audio_file.attached? && ( (audio_file.audio? && audio_file.content_type != 'audio/mpeg') || audio_file.video? )
  end
  
  def playable?
    audio_file.attached? && audio_file.content_type == 'audio/mpeg'
  end

  def duration_formatted
    Time.at(duration.to_i).strftime("%M:%S")
  end

  private
    def convert_to_mp3
      ConvertToMp3Job.perform_later(id) if convertable?
    end

    def get_duration
      GetAudioDurationJob.perform_later(id)
    end
    
    def correct_mime_type
      if audio_file.attached? && !audio_file.audio?
        errors.add(:audio_file, 'Must be an audio file')
      end
    end

end
