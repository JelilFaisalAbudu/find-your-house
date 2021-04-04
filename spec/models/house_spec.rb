require 'rails_helper'

RSpec.describe House, type: :model do
  # Validation test
  # Before save, ensure these fields are present
  it { should(validate_presence_of(:name)) }
  it { should(validate_presence_of(:category)) }
  it { should(validate_presence_of(:description)) }

  # Association test
  # Ensure the House model has 1:m relationship with the Favorite model
  it { should(have_many(:favorites).dependent(:destroy)) }
end
