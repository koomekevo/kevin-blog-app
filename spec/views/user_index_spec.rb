require 'rails_helper'

describe 'user index page tests', type: :feature do
  before :each do
    @user_one = User.create(name: 'userone', bio: 'Engineer', email: 'userone@gmail.com', password: '1234321',
                            posts_counter: 0, confirmed_at: Time.now)
    @user_two = User.create(name: 'usertwo', bio: 'Doctor', email: 'usertwo@gmail.com', password: 'hellomicroverse',
                            posts_counter: 0, confirmed_at: Time.now)
  end

  it 'shows username of the first user' do
    visit root_path
    within('body') do
      fill_in 'Email', with: 'userone@gmail.com'
      fill_in 'Password', with: '1234321'
    end
    click_button 'Log in'
    expect(page).to have_content 'userone'
  end

  it 'shows username of the second user' do
    visit root_path
    within('body') do
      fill_in 'Email', with: 'usertwo@gmail.com'
      fill_in 'Password', with: 'hellomicroverse'
    end
    click_button 'Log in'
    expect(page).to have_content 'usertwo'
  end

  it 'profile image for the first user' do
    visit root_path
    within('body') do
      fill_in 'Email', with: 'userone@gmail.com'
      fill_in 'Password', with: '1234321'
    end
    click_button 'Log in'
    expect(page).to have_css('img')
  end

  it 'profile image for the second user' do
    visit root_path
    within('body') do
      fill_in 'Email', with: 'usertwo@gmail.com'
      fill_in 'Password', with: 'hellomicroverse'
    end
    click_button 'Log in'
    expect(page).to have_css('img')
  end

  it 'shows the number of post value for the first user ' do
    visit root_path
    within('body') do
      fill_in 'Email', with: 'userone@gmail.com'
      fill_in 'Password', with: '1234321'
    end
    click_button 'Log in'
    expect(page).to have_content 'Number of posts: 0'
  end

  it 'show the number of post value for the second user ' do
    visit root_path
    within('body') do
      fill_in 'Email', with: 'usertwo@gmail.com'
      fill_in 'Password', with: 'hellomicroverse'
    end
    click_button 'Log in'
    expect(page).to have_content 'Number of posts: 0'
  end
end
