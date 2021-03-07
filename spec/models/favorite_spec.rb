require 'rails_helper'

RSpec.describe Favorite, type: :model do
  def setup
    @user = User.new(name: 'Example User',
                     email: 'user@example.com',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end

  # Initialize the test data from the factory
  let(:houses) { create_list(:house, 5) }
  let(:user) { create_list(:user, 1).first }
  let(:last_house) { houses.last }

  # Validation test
  it { should(validate_presence_of(:user_id)) }
  it { should(validate_presence_of(:house_id)) }

  # Association test
  it { should(belong_to(:house)) }
  it { should(belong_to(:user)) }

  context 'when both the user and the house exist' do
    it 'creates a favorite for user and house' do
      new_favorite = user.favorites.build(house_id: last_house.id)
      expect(Favorite.exists?(new_favorite.id)).to(eq(false))
      new_favorite_house = House.find(new_favorite.house_id)
      expect(new_favorite).to(be_valid)
      expect(new_favorite.user_id).to(eq(user.id))
      expect(new_favorite_house.name).to(match(last_house.name))

      new_favorite.save
      expect(Favorite.exists?(new_favorite.id)).to(eq(true))
    end
  end

  context 'when a user or a house does not exist' do
    it 'would not creates a favorite for user and house' do
      new_favorite = user.favorites.build(house_id: '')
      new_favorite.save
      expect(Favorite.exists?(new_favorite.id)).to(eq(false))
    end
  end
end
