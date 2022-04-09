require 'rails_helper'
RSpec.describe 'Post #Show', type: :feature do
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
      @post_three = Post.create(title: 'third', text: 'Afternoon', comments_counter: 0, likes_counter: 0,
                                author: @user_two)
      @post_four = Post.create(title: 'fourth', text: 'Evening', comments_counter: 0, likes_counter: 0,
                               author: @user_two)
      @commenta = Comment.create(text: 'Never back down', author: User.first, post: Post.first)

      visit user_post_path(@user_one, @post_one)
    end

    it 'shows posts title' do
      expect(page).to have_content('first')
    end

    it 'can see who wrote the Post' do
      expect(page).to have_content('userone')
    end

    it 'see how many comments' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'can see how many likes' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it 'can see the post body.' do
      expect(page).to have_content('Hello')
    end

    it 'can see the username of the commentor.' do
      post = Post.first
      comment = post.comments.first
      expect(page).to have_content(comment.author.name)
    end

    it 'can see the comments of each commentor.' do
      expect(page).to have_content 'Never back down'
    end
  end
end
