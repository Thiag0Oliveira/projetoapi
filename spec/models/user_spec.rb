require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) {build(:user)}
  #pending "add some examples to (or delete) #{__FILE__}"
  #before {@user = FactoryBot.build(:user)}
  #subject{build(:user)}
  #it{expect(@user).to respond_to(:email)}
  #it{expect(@user).to respond_to(:password)}
  it{is_expected.to validate_presence_of(:email)}
  it{is_expected.to validate_uniqueness_of(:email).case_insensitive}
  it{is_expected.to validate_confirmation_of(:password)}
  it{is_expected.to allow_value("contato.thg@hotmail.com").for(:email)}
end
