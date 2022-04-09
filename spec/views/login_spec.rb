require 'rails_helper'
RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }

  it 'displays email field' do
    expect(page).to have_field('user[email]')
  end

  it 'display Password field' do
    expect(page).to have_field('user[password]')
  end

  it 'Display Login' do
    expect(page).to have_content 'Log in'
  end

  context 'Submit a form' do
    it 'should not submit form without email and password' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  it 'should not submit form with incorrect credentials' do
    within 'form' do
      fill_in 'Email', with: 'koome@gmail.com'
      fill_in 'Password', with: 'kk123454321'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Submit form with correct credentials' do
    @user = User.create(name: 'Kevin', email: 'koomekevo@gmail.com', password: 'password', confirmed_at: Time.now)
    within 'form' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
    end
    click_button 'Log in'
    expect(page).to have_current_path('/')
  end
end
