json.title @recording.title
json.duration = @recording.duration_formatted
json.audio_file_url url_for(@recording.audio_file)
