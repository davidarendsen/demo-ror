require 'test_helper'

class ConvertToMp3JobTest < ActiveJob::TestCase

  test "ensure job runs" do
    assert_enqueued_jobs 0

    Recording.create! title: 'Test.m4a'
    Recording.where(title: 'Test.m4a').first.audio_file.attach(io:
      File.open("#{Rails.root}/test/fixtures/files/example.m4a"), filename: 'test.m4a')

    @recording = Recording.where(title: 'Test.m4a').first

    assert_enqueued_with(job: ConvertToMp3Job, args: [@recording.id], queue: 'default')
  end

  test "ensure job does not run" do
    assert_enqueued_jobs 0

    Recording.create! title: 'Test.mp3'
    Recording.where(title: 'Test.mp3').first.audio_file.attach(io:
      File.open("#{Rails.root}/test/fixtures/files/example.mp3"), filename: 'test.m4a')

    @recording = Recording.where(title: 'Test.mp3').first

    assert_no_enqueued_jobs only: ConvertToMp3Job
  end


end
