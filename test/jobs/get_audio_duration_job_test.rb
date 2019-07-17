require 'test_helper'

class GetAudioDurationTest < ActiveJob::TestCase

  test "ensure job runs" do
    assert_enqueued_jobs 0

    Recording.create! title: 'Test.mp3'
    Recording.where(title: 'Test.mp3').first.audio_file.attach(io:
      File.open("#{Rails.root}/test/fixtures/files/example.mp3"), filename: 'test.mp3')

    @recording = Recording.where(title: 'Test.mp3').first

    assert_enqueued_with(job: GetAudioDurationJob, args: [@recording.id], queue: 'default')
  end

end
