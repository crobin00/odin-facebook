# Odinbook

A social media app inspired by Facebook.

## About

Created as part of [The Odin Project](https://www.theodinproject.com) curriculum.

## Features

- User sign-in and sign-out using [Devise](https://github.com/heartcombo/devise) and [Facebook OmniAuth](https://github.com/simi/omniauth-facebook)
- Friend Requests: sending, canceling, accepting, and unfriending
- Posts (text-only)
- Liking posts
- Commenting on posts
- User page which shows information about their name, email, gender, and amount of friends
  - Also shows profile picture if user uses [Gravatar](https://en.gravatar.com/) or just their Facebook profile picture
- Notifications page which displays all incoming friend requests
- Sends welcome emails when a user signs up
- Styled with Tailwind CSS
- Deployed with [Render](https://render.com)

## Usage

#### Live

[View the app live here.](https://odin-facebook-ny7o.onrender.com/)

If you do not want to make an account:

```
email: example@example.com
password: password
```

_Note: Due to the limitations of Render's free plan, all database data is wiped every 3 months and the server is shut down every month after 750 hours of uptime_

#### Local

To run this app locally, clone this repo, `cd` into the root direction and run:

```
bundle install
bin/dev
```

Then visit http://localhost:3000/ to view the application.

## Possible Improvements

- Use Turbo Frames and Turbo Streams for posts, liking, and commenting to emulate a single-page application to improve user experience.
- ~~Allow posts to be edited~~
- ~~Allow posts to be deleted~~
- ~~Add ability to post images~~
- ~~Allow comments to be edited~~
- ~~Allow comments to be deleted~~
- Allow nested comments
- ~~Allow user uploaded profile pictures~~
- ~~Improve look of user show page~~
- ~~Add ability to decline friend request~~

## Reflections

#### Struggled with Friendship/Friends

I mananged to get the Friendship system working but I assume it wasn't done in the best way. For example, when showing the button to the user for if they want to send, accept, or cancel a friend request, I ended up with this monstrosity:

```
    <% if current_user != @user %>
      <% isRequestedFromThem = FriendRequest.where(sent_user: @user, received_user: current_user) %>
      <% isRequestedFromMe = FriendRequest.where(sent_user: current_user, received_user: @user) %>
      <% noRequest = FriendRequest.where(sent_user: current_user, received_user: @user) %>
      <% if isRequestedFromThem.exists? %>
        # Show accept request button
      <% elsif isRequestedFromMe.exists? %>
        # Show cancel request button
      <% elsif !@user.friends.include?(current_user) && !noRequest.exists? %>
        # Show cancel request button
      <% elsif @user.friends.include?(current_user) %>
        # Show unfriend button
      <% end %>
    <% end %>
```

If I were to go back I would have tried to find out a way to do some of this logic in the controller instead of the view.

I also struggled with creating an inverse friendship when a user accepts a friend request. I tried using an `after_create` callback to create the inverse relationship but the server would try creating endless of the same active record objects. So instead I did this

```
current_user.friendships.create(friend: friend)
friend.friendships.create(friend: current_user)
```

in the controller and the problem was fixed. All in all, friendships were a rough hurdle to solve but I managed to scrape together a solution.

Overall, I learned so much throughout the development of this app and I feel much more confident in my abilities to build a full-fledged Ruby on Rails app.
