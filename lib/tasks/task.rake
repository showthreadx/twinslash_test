namespace :task do
  task :archive_ad => [:environment] do
    published_ad = Ad.where(status: 'published_ad')
    published_ad.each do |ad|
      time = (Time.now - ad.updated_at) / 60 / 60 / 24
      ad.update(status: 'archived_ad') if time > 3
    end
  end

  task :publish_ad => [:environment] do
    Ad.where(status: 'approved_ad').update(status: 'published_ad')
  end
end
