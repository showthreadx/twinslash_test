require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures email presence' do
      user = User.new(id: 1, password: 'sample').save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(id: 2, email: 'sample_email@gmail.com ').save
      expect(user).to eq(false)
    end

    it 'ok with all attributes' do
      user = User.new(id: 3, email: 'sample_email@gmail.com', password: 'sample').save
      expect(user).to eq(true)
    end
  end
end
