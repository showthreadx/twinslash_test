require 'rails_helper'

RSpec.describe Ad, type: :model do
  context 'validation tests' do
    User.create(id: 1, email: 'sample@gmail.com', password: 'sample')
    AdType.create(id: 1, name: 'sample')

    it 'ensures title presence' do
      ad = Ad.new(description: "Sample", user_id: 1, ad_type_id: 1).save
      expect(ad).to eq(false)
    end

    it 'ensures description presence' do
      ad = Ad.new(title: "Sample", user_id: 1, ad_type_id: 1).save
      expect(ad).to eq(false)
    end

    it 'ensures user_id presence' do
      ad = Ad.new(title: "Sample", description: "Sample", ad_type_id: 1).save
      expect(ad).to eq(false)
    end

    it 'ensures ad_type_id presence' do
      ad = Ad.new(title: "Sample", description: "Sample", user_id: 1).save
      expect(ad).to eq(false)
    end

    it 'default status test' do
      ad = Ad.new(title: "Sample", description: "Sample", user_id: 1, ad_type_id: 1)
      new_ad = ad.update(status: 'new_ad')
      expect(ad).to_not eq(new_ad)
    end

    it 'should save successfully' do
      ad = Ad.new(title: "Sample", description: "Sample", user_id: 1, ad_type_id: 1, status: 'new_ad').save
      expect(ad).to eq(true)
    end
  end
end
