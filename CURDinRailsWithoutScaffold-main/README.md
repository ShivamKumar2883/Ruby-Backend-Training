# CURDinRudy  

A Ruby on Rails application demonstrating CRUD operations.  

## Important Files & Structure  

### Core Directories:  
- **`app/controllers/user_controller.rb`**  
  - Handles user-related actions (create, read, update, delete).  
- **`app/views/`**  
  - Contains ERB templates for user interfaces.  
- **`config/routes.rb`**  
  - Defines URL mappings and RESTful routes.  
- **`models/user.rb`**  
  - User model (database interactions/validations).  
- **`db/seeds.rb`**  
  - Seed data for populating the database.  

### How to Run:  
1. Install dependencies: `bundle install`  
2. Setup database: `rails db:migrate`  
3. Run seeds: `rails db:seed`  
4. Start server: `rails s`  
