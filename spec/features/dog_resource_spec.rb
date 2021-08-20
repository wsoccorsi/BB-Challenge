require 'rails_helper'

describe 'Dog resource', type: :feature do
  let(:user) { create(:user) }

  before(:each) do
    allow_any_instance_of(DogsController).to receive(:current_user).and_return(user)
  end

  it 'can create a profile' do
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  context 'with correct owner' do
    it 'can edit a dog profile' do
      dog = create(:dog, user: user)
      visit edit_dog_path(dog)
      fill_in 'Name', with: 'Speck'
      click_button 'Update Dog'
      expect(dog.reload.name).to eq('Speck')
    end

    it 'can delete a dog profile' do
      dog = create(:dog, user: user)
      visit dog_path(dog)
      click_link "Delete #{dog.name}'s Profile"
      expect(Dog.count).to eq(0)
    end
  end

  context 'with incorrect owner' do
    before(:each) do
      new_user = create(:user, id: 4, email: 'blah@email.com')
      allow_any_instance_of(DogsController).to receive(:current_user).and_return(new_user)
    end

    it 'cannot edit a dog profile' do
      dog = create(:dog, user: user)
      visit dog_path(dog)
      expect(page).not_to have_text("Edit")

      visit edit_dog_path(dog)
      expect(current_path).to eql('/')
    end

    it 'cannot delete a dog profile' do
      dog = create(:dog, user: user)
      visit dog_path(dog)
      expect(page).not_to have_text("Delete")
    end
  end
end
