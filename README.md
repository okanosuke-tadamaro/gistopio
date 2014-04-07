###Gistopio

Gistopio is a simple notetaking web-app which partially syncs with GitHub Gists. You can take notes in markdown and the codeblocks will be syntax highlighted for great readability. Users will have a choice of making notes public or private, and a choice of syncing with gists.

The app can be accessed on heroku at http://gistopio.herokuapp.com

###ERD
![erd](http://okaoka.miraiserver.com/ga/project1.jpg)

###Gems and APIs
Gems used in this project:

- Octokit (GitHub API)
- Redcarpet
- Coderay

###Completed User Stories

- As a user, I want to login using my GitHub account so I don' t have to make another online account
- As a user, I want to post notes and save it to a database so I can access it form anywhere
- As a user, I want to see my GitHub photo on my comments so other people will know who I am
- As a user, I want to comment on other users posts so I can communicate with them
- As a user, I want to make specified posts a gist on GitHub so I can make it accessible to other GitHub users
- As a user, I want to update my gists to the current state every time I log in
- As a user, I want to publish posts in markdown format so I have a unified format on all of my posts
- As a user, I want to tag my posts so I can find them easily
- As a user, I want to be signed in whenever I am using the service so I can use the service continuously
- As a user, I want to have my code blocks syntax highlighted so it can be more readable

https://www.pivotaltracker.com/projects/1046238

###Changes
- removed new route action view
- moved tag create logic from posts controller to tag model
- refactored create gist conditional to one line
- removed edit view and action
- moved tag update logic from post controller to tag model
- moved update gists logic to post model
- refactored destroy action in posts controller
- refactored each block for list_tags method in app controller to one line
- refactored redirect conditional to one line in authorize method
- minor css refactor
- removed duplicate css