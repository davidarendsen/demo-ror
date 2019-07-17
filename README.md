# Readme

This is a demo of a simple Ruby on Rails application.
With the application a logged in user can upload audio files.
After uploading you can listen to it.

Unfortunately there aren't many audio formats supported in the browser.
The ConvertToMp3Job can solve this by converting non-MP3 audio files to MP3.

ConvertToMp3Job works with the streamio-ffmpeg gem.
This requires ffmpeg installed on the server.

GetAudioDurationJob retrieves the duration of the audio file.

## Installation
```
bundle install
rails db:migrate db:seed
rails s
```

## Testing
```
rails test
```
