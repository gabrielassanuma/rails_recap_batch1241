## Rails Recap Class - Batch 1241


## Create local setup

Inside your code folder:

```bash
  mkdir rails_recap_batch1241
  cd rails_recap_batch1241
```

Set up Le Wagon minimal rails template:
```bash
  rails new \
  -d postgresql \
  -j webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/minimal.rb \
  rails_recap_batch1241
```

Create repo and push it to github:
```bash
  git init
  git add .
  git commit -m "First commit"
  gh repo create --public --source=.
  git push origin main
```

Your can check your repo on browser with this command on terminal:
```bash
  gh repo view --web
```

## Model

We NEVER 🙅🏻‍♂️ work on MASTER!🙅🏽‍♀️

Create a branch before move on:
```bash
  git checkout -b model-creation
```

Create model Post:
```bash
  rails g model Post title content
```
Create db and migrate:
```bash
  rails db:create
  rails db:migrate
```

Let's create some posts on our seed file

Start by including faker in your Gemfile:
```bash
   gem 'faker'
```

Run bundle install:
```bash
   bundle install
```

On your seed.rd:
```bash
  require 'faker'

  puts "Dropping data..."
  Post.destroy_all
  puts "Creating new seed"
  5.times do | index |
    puts "creating #{index + 1} Post"
    Post.create(title: Faker::Book.title, content: Faker::Lorem.paragraph)
    puts "#{index + 1} Post created!"
  end
```

Run rails db:seed:
```bash
  rails db:seed
```

Check Posts on console:
```bash
   rails console
```

Push changes to github:
```bash
   git add .
   git commit -m "created post model, generated db, add faker gem add seeds to post"
   git push origin model-creation 
```

## Action Index Posts (show all)

Always remember...
We NEVER 🙅🏻‍♂️ work on MASTER!🙅🏽‍♀️

Create a branch before move on
```bash
  git checkout -b index-posts
```

Create Posts controller
```bash
   rails g controller posts
```

Do you remember this pattern?
route ➡️ controller#action ➡ view
Here we go again! 👩🏽‍💻

In your config folder open routes.rb add the path for our first action, index will be our root path also.
```bash
   root "posts#index"
   get "/posts", to: "posts#index"
```

Go to app/controllers/posts and add index function:
```bash
  def index
    @posts = Post.all
  end
```

Go to app/views/posts and create file index.html.erb and copy this code:
```bash
  <div class="container">
    <div class="row">
      <div class="col6 my-5 d-flex justify-content-center">
        <h1>I LOVE RAILS ❤️</h1>
      </div>
    </div>
    <div class="cards">
      <% @posts.each do | post | %>
        <div class="card">
          <div class="card-header">
            <%= "Card for post - #{post.id}" %>
          </div>
          <div class="card-body">
            <h5 class="card-title"><%= post.title %></h5>
            <p class="card-text"><%= post.content %></p>
            <a href="#" class="btn btn-light">Go somewhere</a>
          </div>
        </div>
      <% end %>
    </div>
  </div>
```

Go to app/assets/stylesheets create one posts folder, inside it create one file index.sccs and copy this code:
```bash
  .cards {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-gap: 18px;
}
```

Don't forget to import it to application.scss ⤵️ ❗️
```bash
  @import "posts/index";
```

Push changes to github:
```bash
   git add .
   git commit -m "created posts controller, add index to routes, set index#posts to root, created index posts file added index.sccs"
   git push origin index-posts
```
## Action Show

Create a branch before move on
```bash
  git checkout -b show-post
```

Add route for show action, using resources
```bash
 resources :posts, only: [:index, :show]
```

Time to implement action on controller:
```bash
  def show
    @post = Post.find(params[:id])
  end
```

Go to app/views/posts and create file show.html.erb and copy this code:
```bash
  <div class="container">
    <div class="row">
      <div class="col-12 my-5 d-flex justify-content-center">
        <div class="card">
          <div class="card-header">
            One post
          </div>
          <div class="card-body">
            <h5 class="card-title"><%= @post.title %></h5>
            <p class="card-text"><%= @post.content %></p>
          </div>
          <div class="card-footer text-muted">
            I ❤️ rails!
          </div>
        </div>
      </div>
    </div>
  </div>
```

Push changes to github:
```bash
   git add .
   git commit -m "added show to routes, set show#posts and created view show"
   git push origin show-posts
```


## Action Create

Create a branch before move on:
```bash
  git checkout -b create-posts
```

Add new route to router.rb:
```bash
  resources :posts, only: [:index,:new, :create, :show]
```

Go to app/controllers/posts and add function:
```bash
  def new
    @post = Post.new
  end
```

Go to app/views/posts and create file new.html.erb and copy this code:
```bash
  <div class="container">
    <div class="row">
      <div class="w-60 my-5 d-flex justify-content-center">
        <%= simple_form_for(@post) do |f| %>
          <%= f.input :title %>
          <%= f.input :content %>
          <%= f.submit %>
        <% end %>
      </div>
    </div>
  </div>
```

Let's go back to post controller and add create function:
```bash
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
```

Time to set-up parameters coming from the view:
```bash
  private 

  def post_params
    params.require(:post).permit(:title, :content)
  end
```

Push changes to github:
```bash
  git add .
  git commit -m "created new and create function on post controller, set view for new post, added strong parametes, routes for new and create"
  git push origin create-posts
```

## Action Edit 

Create a branch before move on:
```bash
  git checkout -b edit-posts
```

Add new route to router.rb:
```bash
  resources :posts, only: [:index,:new, :create, :show, :edit]
```

Go to app/controllers/posts and add function:
```bash
  def edit
    @post = Post.find(params[:id])
  end
 ```
 
Go to app/views/posts and create file edit.html.erb, as we will use the same form from new.html.erb, let's apply DRY and render the form.
Create inside app/views/posts one file _form.html.erb and insert our simple form:
```bash
  <%= simple_form_for(@post) do |f| %>
    <%= f.input :title %>
    <%= f.input :content %>
    <%= f.submit %>
  <% end %>
```

Now go back to edit.html.erb and paste it:
```bash
  <div class="container">
    <div class="row">
      <div class="w-60 my-5 d-flex justify-content-center">
        <%= render "form", post: @post %>
      </div>
    </div>
  </div>
 ```
 
 Don't forget to change new.html.erb file using our _form rener
 
 Time to come back to controller and create update function:
```bash
    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end
```

Push changes to github:
```bash
  git add .
  git commit -m "added update routes, included edit and update functions on post controller, applied DRY to post simple form, changed new.html.erb, added edit.html.erb"
  git push origin edit-posts
```

## Time to play with nested action, let's add reviews to our posts

## Generate review model

Create a new branch:
```bash
  git checkout add-review-to-post
```

On your terminal:
```bash
  rails generate model Review content:text post:references
```

Set relationship between review and post models:
```bash
 class Post < ApplicationRecord
   has_many :reviews, dependent: :destroy
 end
```
```bash
  class Review < ApplicationRecord
    belongs_to :post
  end
```

## Action new review

On router.rb:
```bash
  Rails.application.routes.draw do
    root "posts#index"
    resources :posts, only: [:index, :new, :create, :show, :edit, :update] do
      resources :reviews, only: [:new, :create]
    end
end
end
```

Generate Review Controller on terminal:
```bash
  rails g controller reviews new
```

On your review controller add the function:
```bash
  def new
    @Post = Post.find(params[:post_id])
    @review = Review.new
  end
```

Go to app/views/reviews and create file new.html.erb and copy this code:
```bash
  <div class="container">
    <div class="row">
      <div class="w-60 my-5 d-flex justify-content-center">
        <%= simple_form_for [@post, @review] do |f| %>
          <%= f.input :content %>
          <%= f.submit "Submit review" %>
        <% end %>
      </div>
    </div>
  </div>
```

And go back to the controller and set function create and strong params:
```bash
   def create
    @post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.post = @post
    if @review.save
      redirect_to post_path(@post)
    else 
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
```

Change show view for this:
```bash
  <div class="container">
    <div class="row">
      <div class="col-12 my-5 d-flex justify-content-center">
        <div class="card">
          <div class="card-header">
            One post
          </div>
          <div class="card-body">
            <h5 class="card-title"><%= @post.title %></h5>
            <p class="card-text"><%= @post.content %></p>
          </div>
          <div class="card-footer text-muted">
            I ❤️ rails!
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="w-10 d-flex justify-content-between">
        <%= link_to "Add new review", new_post_review_path(@post), class: "btn btn-light" %>
        <%= link_to "Back to index", root_path, class: "btn btn-light" %>
      </div>
    </div>
    <div class="row">
      <div class="col-12 justify-content-center mt-5">
        <p><strong>Reviews</strong></p>
        <ul class="list-group">
          <% @post.reviews.each do |review| %>
            <li class="list-group-item"><%= review.content %></li>
          <% end %>
        </ul>
        <br>
      </div>
    </div>
  </div>
```

## Final touch
Replace seed.rb
```bash
    require 'faker'

  puts "Dropping data..."
    Post.destroy_all
    puts "Creating new seed"

    MODULES_LW = ["Ruby", "OOP", "DATABASE", "FRONT-END", "RUBY ON RAILS", "PROJECTS"]
    MODULE_CONTENT = ["Ruby, a dynamic and expressive language, is covered in 6 blocks. The first covers programming basics, variables, methods, and built-in classes. The second focuses on flow control, conditionals, and arrays. The third explores powerful iterators like 'each' and 'map,' along with Ruby blocks called with 'yield.' The fourth introduces hashes, ideal for key-value pairs, and symbols for efficient identifiers. These blocks provide a foundation for mastering Ruby's readability and productivity.",
      "OOP module has 6 blocks covering classes, instances, inheritance, and software architecture. Block 1 focuses on defining classes, instances, variables, methods, constructors, and accessors. Block 2 covers advanced concepts like inheritance, class methods, and 'self' keyword. The software architecture block introduces MVC pattern and builds a cookbook app over 2 blocks. Block 4 concludes the cookbook app with a recap and optional adaptation to a web-app using Sinatra gem. The data models section consists of the Food Delivery challenge spread across 2 blocks. It covers dealing with multiple data models and encourages persistence. The final block offers a recap and livecode session for completing the Food Delivery app",
      "The Database & Active Record module consists of 4 blocks. Block 1 covers schema design, relational databases, and SQL queries for reading data. Block 2 delves into CRUD operations and introduces SQL keywords for writing data. Block 3 explores Active Record, a powerful Ruby library that connects objects to databases. It explains how Active Record models are linked to tables through naming conventions. Block 4 focuses on associations and validations within Active Record, providing a deeper understanding of data relationships and data integrity.",
      "The Front-end module consists of 8 lectures, including 7 days of content and 1 project-day for final project preparation. Day 1 covers HTML and CSS concepts, building a profile page and deploying it using GitHub Pages. Day 2 focuses on creating a CSS component library and organizing components. Day 3 introduces Bootstrap, grids, layouts, and responsive design techniques. Day 4 begins the JavaScript submodule, exploring the basics and algorithmic challenges. Day 5 dives into the DOM, events, and building dynamic interfaces. Day 6 covers HTTP, AJAX, and fetching content dynamically. Day 7 explores using JavaScript plugins and organizing code in a front-end app. The final day is dedicated to product design and prototyping, culminating in a demo presentation.",
      "The Rails module consists of 10 lectures, covering two weeks of learning. The first week, Rails 101, focuses on building a Rails app each day. Topics include routing, controllers, views, models with CRUD actions, advanced routing, front-end setup, hosting, image upload, and core Rails concepts. In the second week, students work on the Airbnb project in teams, building an MVP clone. Morning lectures cover authentication, authorization, geocoding, search techniques, and AJAX integration. Quizzes and demos evaluate progress. By the end, students have a solid understanding of Rails and its components for developing web applications.",
      "In the Projects module, students embark on their final journey in the program. Time is of the essence, and they are encouraged to deploy their projects frequently. Key milestones include an intermediate demo for feedback, a dress rehearsal, and the grand Demoday event. Project instructions on Kitt provide guidance for effective project management and coding practices. Morning lectures cover advanced topics such as real-time features with ActionCable, building APIs, utilizing Sidekiq for background jobs, and mastering advanced SQL queries for data presentation. This module prepares students for the culmination of their hard work and showcases their projects to a wider audience."
    ]

    6.times do | index |
      Post.create(title: MODULES_LW[index], content: MODULE_CONTENT[index])
    end             
```







