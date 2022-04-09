require 'rails_helper'

RSpec.describe 'User #Show', type: :feature do
  describe 'shows users' do
    before(:each) do
      @user_one = User.create(name: 'userone', bio: 'Engineer', email: 'userone@gmail.com', password: '1234321',
                              posts_counter: 0, confirmed_at: Time.now)
      @user_two = User.create(name: 'usertwo', bio: 'Doctor', email: '@usertwo@gmail.com',
                              password: 'hellomicroverse', posts_counter: 0, confirmed_at: Time.now)

      visit root_path
      fill_in 'Email', with: 'userone@gmail.com'
      fill_in 'Password', with: '1234321'
      click_button 'Log in'
      @post_one = Post.create(title: 'first', text: 'Hi', comments_counter: 0, likes_counter: 0,
                              author: @user_one)
      @post_two = Post.create(title: 'Second', text: 'Howdy', comments_counter: 0, likes_counter: 0,
                              author: @user_one)
      @post_three = Post.create(title: 'third', text: 'Bonjour', comments_counter: 0, likes_counter: 0,
                                author: @user_one)
      @post_four = Post.create(title: 'fourth', text: 'Morning', comments_counter: 0, likes_counter: 0,
                               author: @user_one)
      visit user_path(@user_one.id)
    end

    it "shows user's profile picture" do
      expect(page).to have_css('img')
    end

    it "shows user's Bio" do
      expect(page).to have_content('Engineer')
    end

    it "show user's name" do
      expect(page).to have_content 'userone'
    end

    it 'shows number of posts user written' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'shows button to see all posts.' do
      expect(page).to have_link('See all posts')
    end

    it "the user's first 3 posts are available" do
      expect(page).to have_text('Bonjour')
    end
  end
end
