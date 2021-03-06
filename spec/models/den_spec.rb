require 'rails_helper'

describe Den do
  it {should validate_presence_of :user_id}
  it {should validate_presence_of :name}
  it {should validate_presence_of :description}
  it {should validate_uniqueness_of(:name).scoped_to(:user_id)}


  it {should have_many :reviews}
  it {should belong_to :user}
end
