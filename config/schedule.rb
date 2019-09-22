every :day, at: '11:50 pm' do
  rake 'task:archive_ad'
end

every :day, at: '0:00 am' do
  rake 'task:publish_ad'
end
