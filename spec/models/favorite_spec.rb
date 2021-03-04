require 'rails_helper'

RSpec.describe Favorite, type: :model do
  # Validation test
  it { should(validate_presence_of(:user_id)) }
  it { should(validate_presence_of(:house_id)) }

  # Association test
  it { should(belong_to(:house)) }
end
