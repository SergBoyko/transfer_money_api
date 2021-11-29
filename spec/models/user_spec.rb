require 'rails_helper'


describe Api::V1::User do
  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_presence_of :amount }
  end
end