require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation test
  # Before save, ensure these fields are present
  it { should(validate_presence_of(:name)) }
  it { should(validate_presence_of(:email)) }
  it { should(validate_presence_of(:password_digest)) }

  # Association test
  # Ensure Todo model has 1:m relationship with the Favorite model
  it { should(have_many(:favorites).dependent(:destroy)) }
end
