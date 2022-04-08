require 'rails_helper'
RSpec.describe 'User #Show', type: :feature do
  describe 'shows users' do
    before(:each) do
      @user_one = User.create(name: 'userone', bio: 'Doctor', email: 'userone@gmail.com', password: '1234321',
                              posts_counter: 0, confirmed_at: Time.now)
      @user_two = User.create(name: 'usertwo', bio: 'Engineer', email: 'usertwo@gmail.com', password: 'hellomicroverse',
                              posts_counter: 0, confirmed_at: Time.now)

      visit root_path
      fill_in 'Email', with: 'userone@gmail.com'
      fill_in 'Password', with: '1234321'
      click_button 'Log in'
      @post_one = Post.create(title: 'first', text: 'Hello', comments_counter: 0, likes_counter: 0, author: @user_one)
      @post_two = Post.create(title: 'Second', text: 'Morning', comments_counter: 0, likes_counter: 0,
                              author: @user_one)
      @post_three = Post.create(title: 'third', text: 'Evening', comments_counter: 0, likes_counter: 0,
                                author: @user_one)
      @post_four = Post.create(title: 'fourth', text: 'Afternoon', comments_counter: 0, likes_counter: 0,
                               author: @user_one)
      @comment_one = Comment.create(text: 'Never back down', author: User.first, post: Post.first)
      visit(user_posts_path(@user_one.id))
    end

    it "shows user's profile picture" do
      expect(page).to have_css('img')
    end

    it 'shows username of the first user' do
      visit(user_posts_path(@user_one.id))
      expect(page).to have_content 'userone'
    end

    it 'shows number of posts' do
      post = Post.all
      expect(post.size).to eql(4)
    end

    it 'shows number of posts of a user' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'see the number of likes' do
      expect(page).to have_content 'Likes: 0'
    end

    it 'can see how many comments a post has.' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'shows commentor username' do
      visit(user_posts_path(@user_one.id))
      expect(page).to have_content 'userone'
    end

    it 'The posts title is visible' do
      expect(page).to have_content 'first'
    end

    it 'The posts text is visible' do
      expect(page).to have_content 'Hello'
    end

    it 'The first comments in the post are visible' do
      expect(page).to have_content 'Never back down'
    end

    scenario 'When clicking on a post, the page redirects to that post page' do
      sleep(5)
      click_link 'first'
      expect(page.current_path).to eq "/users/#{@user_one.id}/posts/#{@post_one.id}"
    end
  end
end
