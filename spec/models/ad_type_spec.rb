require 'rails_helper'

RSpec.describe AdType, type: :model do
  context 'validation tests' do
    it 'ensures ad_type name is unique' do
      ad_type = AdType.create(name: 'sample')
      expect(ad_type).to_not be_valid
    end
  end
end
