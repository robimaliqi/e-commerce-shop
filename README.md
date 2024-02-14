<!-- <div align="center" id="top">
  <img src="./.github/app.gif" alt="App" />

&#xa0; -->

  <!-- <a href="https://app.netlify.app">Demo</a> -->
</div>

<h1 align="center">E-commerce Shop</h1>

<p align="center">
  <img alt="Github top language" src="https://img.shields.io/github/languages/top/robimaliqi/e-commerce-shop?color=56BEB8">

  <img alt="Github language count" src="https://img.shields.io/github/languages/count/robimaliqi/e-commerce-shop?color=56BEB8">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/robimaliqi/e-commerce-shop?color=56BEB8">

  <!-- <img alt="License" src="https://img.shields.io/github/license/robimaliqi/app?color=56BEB8"> -->

  <!-- <img alt="Github issues" src="https://img.shields.io/github/issues/robimaliqi/app?color=56BEB8" /> -->

  <!-- <img alt="Github forks" src="https://img.shields.io/github/forks/robimaliqi/app?color=56BEB8" /> -->

  <!-- <img alt="Github stars" src="https://img.shields.io/github/stars/robimaliqi/app?color=56BEB8" /> -->
</p>

<!-- Status -->

<!-- <h4 align="center">
	🚧  App 🚀 Under construction...  🚧
</h4>

<hr> -->

<p align="center">
  <a href="#dart-about">About</a> &#xa0; | &#xa0; 
  <a href="#sparkles-features">Features</a> &#xa0; | &#xa0;
  <a href="#rocket-technologies">Technologies</a> &#xa0; | &#xa0;
  <a href="#white_check_mark-requirements">Requirements</a> &#xa0; | &#xa0;
  <a href="#checkered_flag-starting">Starting</a> &#xa0; | &#xa0;
  <!-- <a href="#memo-license">License</a> &#xa0; | &#xa0; -->
  <a href="https://github.com/robimaliqi" target="_blank">Author</a>
</p>

<br>

## :dart: About

A e-commerce shop where the user is able to add items to cart, to checkout the user has to sign up and log in. After logging in they are directed to stripe checkout integration where they are able to process their payment.

## :sparkles: Features

:heavy_check_mark: User Authentication using device<br>
:heavy_check_mark: Stripe checkout<br>
:heavy_check_mark: Populating items using Faker and unsplash api for photos<br>
:heavy_check_mark: Pagination<br>
:heavy_check_mark: Sorting Items by price<br>
:heavy_check_mark: Turbo streams for updating without refreshing page

## :rocket: Technologies

The following tools were used in this project:

- [Ruby](https://www.ruby-lang.org/)
- [Ruby on Rails](https://rubyonrails.org/)
- [Turbo-Hotwire](https://turbo.hotwired.dev/)
- [Bootstrap](https://getbootstrap.com/)

## :white_check_mark: Requirements

Before starting :checkered_flag:, you need to have [Git](https://git-scm.com) and [Ruby](https://www.ruby-lang.org/) installed.

## :checkered_flag: Starting

```bash
# Clone this project
$ git clone https://github.com/robimaliqi/e-commerce-shop

# Access
$ cd e-commerce-shop

# Install Gems
$ bundle install

# Database setup
$ rails db:setup

# Run the project
$ ./bin/dev

# Run tests
$ bundle exec rspec

# The server will initialize in the <http://localhost:3000>
```

<a href="#top">Back to top</a>
