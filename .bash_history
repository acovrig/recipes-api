rails g scaffold recipe name author serving_size:integer serving_suggestion rating:float
rails g scaffold category name
rails g scaffold recipe_category recipe:references category:references
rails g scaffold ingredient recipe:references qty:float unit item note:text
rails g scaffold direction recipe:references step:integer action
rails g scaffold pictures recipe:references fname sum width:integer height:integer size:integer
rails g scaffold note recipe:references note:text
ls app/models
rake db:migrate
