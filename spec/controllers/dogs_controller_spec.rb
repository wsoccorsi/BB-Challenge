require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  let(:user) { create(:user) }
  let(:file1) { fixture_file_upload(Rails.root.join('spec', 'factories', 'images', 'bowie_toys.jpg')) }
  let(:file2) { fixture_file_upload(Rails.root.join('spec', 'factories', 'images', 'bowie_toys.jpg')) }

  before(:each) do
    allow_any_instance_of(DogsController).to receive(:current_user).and_return(user)
  end

  describe '#index' do
    it 'displays recent dogs and paginates correctly' do
      10.times { create(:dog) }
      get :index
      expect(assigns(:dogs).size).to eq(5)
    end
  end

  # Assumption: Only editing the cases I changed to save time
  describe '#create' do
    it 'attaches multiple images' do
      dog_params = { "name"=>"Gus", "description"=>"Doxin","images"=>[file1, file2] }
      post :create, params: { 'dog' => dog_params }

      dog = Dog.find_by_name('Gus')
      expect(dog.images.count).to eq(2)
    end
  end

  describe '#update' do
    it 'attaches new images and removes old images' do
      dog_params = { "name"=>"Gus", "description"=>"Doxin","images"=>[file1, file2] }
      post :create, params: { 'dog' => dog_params }
      dog = Dog.find_by_name('Gus')

      dog_params = { "name"=>"Gus", "description"=>"Doxin","images"=>[file1] }
      put :update, params: { 'id' => dog.id, 'dog' => dog_params }

      expect(dog.images.count).to eq(1)
    end
  end
end
