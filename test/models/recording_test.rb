require 'test_helper'

class RecordingTest < ActiveSupport::TestCase
  test "should not save recording without title" do
    recording = Recording.new
    assert_not recording.save, "Saved the recording without a title"
  end

  test "updates recording with calculated audio duration" do
    Recording.create! title: 'Test.mp3'
    Recording.where(title: 'Test.mp3').first.audio_file.attach(io: 
      File.open("#{Rails.root}/test/fixtures/files/example.mp3"), filename: 'test.mp3')

    recording = Recording.where(title: 'Test.mp3').first

    assert recording.duration_formatted, '02:45'
  end
end
