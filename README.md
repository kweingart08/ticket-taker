# TICKET TAKER
!['ERD'](https://github.com/kweingart08/ticket-taker/blob/master/ticket-taker.png)

## Purpose
  The purpose of this application is to provide a Rails app for someone opening a movie theater to start selling tickets online. 
  
  Note: There is no credit card processor or admin authentication so please do not use this app for actual selling of movie tickets. 

## Link to Live Site
  Here is the link to the live site:
  [https://ticket-taker.herokuapp.com/]

## Build Process 
  In order to complete this challenge and help direct the build process, I started by creating a high-level process diagram. The image below shows the high-level process used to complete the ticket-taker application. This is the process that will be explained in more details below. 
  !['process-diagram'](https://github.com/kweingart08/ticket-taker/blob/master/ChallengeHighLevel-Process.png)

#### Determine Requirements
  Using the challenge description, I pulled out all of the key requirements and made the following list: 
  
  REQUIREMENTS: 
  
    1. When customers go to the site, they must see all movies playing with their showtimes. 
    2. Seating must be limited for each theater/showtime.
    3. Once a show sells out, a customer should no longer be able to buy tickets. 
    4. Customers can buy more than one ticket for one show at a time (no shopping cart). 
    5. If a customer decides to buy tickets, they can checkout with name, email, CC, and expiration date (Make sure no bogus orders & No CC processor needed yet).
    6. Upon successful order completion, customer receives an email with their order (styling not needed). 
    7. For admin: Order information should be saved to database. 
    8. For admin: Order details should be able to be viewed. 
    9. Needs to work on mobile. 
    
#### Determine Data Tables / Models 
  The next step in my process was to determine what data tables I would need and what the models were going to look like. I determined I needed the following: 
  
  - Movies -- to hold the movie title.
    - Has Many: showtimes, orders through showtimes 
    - Has and Belongs to Many: screens
    - Validations: make sure when creating that a title is put in so that a blank movie cannot be created. 
  - Screens -- to hold the room number and the capacity of the room 
    - Has Many: showtimes, orders through showtimes
    - Has and Belongs to Many: movies 
    - Validations: make sure that a room number and capacity is present before submitting.
  - Showtimes -- to hold the time of the movie, how many tickets have been sold for that specific time, and the price. The price could be different if it is a matinee time. 
    - Has Many: orders 
    - Belongs To: movie, screen
  - Order -- to hold all of the orders that are placed. 
    - Belongs To: showtime 
    - Validations: name, email, credit card number, expiration date, and quantity are present before submitting. This also will check that the expiration date is not earlier than today's date, uses the luhn algorithm to detect a valid credit card number. 
    
  An ERD of these can be seen below: 
  !['ERD'](https://github.com/kweingart08/ticket-taker/blob/master/ERD.png)

#### Create Rails Project 
  A new rails project was created (ticket-taker). The project was setup to have a Postgres database so that the process of deploying on Heroku would be simpler later.  

#### Generate Controllers & Models / Routes and Views
   Controllers, models, routes, and views were created in the following order: 
    - Screens 
    - Movies 
    - Showtimes 
    - Orders 
    
   These were all created one at a time, checking that all CRUD routes were created and working correctly. The first round of build was focused on functionality. When the orders routes were created, they were created inside of the showtimes route so that each order could easily be associated to that showtime. 
   
   All forms include a check for any errors using the validations that were put in place for the models. If there are any errors, the user will be given an alert on the form page. 
   
   1) Showtimes NEW Form -- this form using collection_select for both the screen and the movie. In order to create a new showtime, the admin would use the movies and screens that are in the database. Ideally later, this would be able to make sure that things aren't double booked. 
   
   2) Showtimes SHOW VIEW -- this is where there is a check to make sure there are still tickets to be sold. If the difference of the screen capacity and the tickets sold is greater than 0, then it will show a link to buy tickets. If not, it will say SOLD OUT. 
   
   3) Orders NEW Form -- this uses a f.select option for quantity that goes from 1 to how many tickets are left. This helps to make sure that someone does not try to purchase more tickets than are available. 
   

#### Generate Email Confirmation 
  This was a new task for me so I watched a few different online tutorial videos and did some searching on google. Ultimately, I generated an order mailer that would take the order that was just created (if saved and successfully created) and mail it to the email that was put into the order form. An html and text view was created to send the title of the movie, the quantity bought, and the total that was charged. I also added a success alert to show up on the page when the order was successfully submitted. 
  
  Other items added/updated: 
  
    - in config/environments/development.rb: 
      - Turned delivery errors to true so that I could see why it wasn't working. 
      - Added delivery method of smtp and set up my smtp settings 
      - Added default url to my local host 
      - Created a local .yml file to store my environmental variables of email and password to send from. 
    - in config/environments/production.rb: 
      - Added delivery method of smtp and set up my smtp settings 
      - Added default url to my heroku url 
      - Changed config.assets.compile to true
    - in OrdersController: 
      - Added OrderMailer.new(@order).deliver_now so that if an order was created, it would send the email. 

#### Create Dashboard for Admin 
  When I got to the dashboard for admin, I decided re-organize my site. I moved all of the "create" links and "show" for movies, screens, and orders to be inside the admin page. This way when I user comes to the site, they see showtimes on the main page (without the edit and delete buttons showing). If that person is admin, they can click admin and see all of their options to add or view the other data. 

  All of the order information and dashboard is found in the '/get' route for orders. This site includes the following: 
  
  * Table showing all orders.
  * Filter option to put in a movie name and see only those orders. 
  * Total Revenue is shown on top as well as at the bottom of the table. It is updated depending on the filtered view. 
  * Using the 'chartkick' gem, created column and bar charts to show the total tickets sold and revenue by movie title, time of day, and day of week. 

#### Review Requirements and Add Changes 
  At this point, the app is functioning, so this was a final go back and make sure all requirements have been met and update accordingly. 
  
    1. When customers go to the site, they must see all movies playing with their showtimes. 
      * COMPLETE -- changed index route to '/get' showtimes
      
    2. Seating must be limited for each theater/showtime.
      * COMPLETE -- all showtimes are linked to a screen which has a capacity 
      
    3. Once a show sells out, a customer should no longer be able to buy tickets. 
      * COMPLETE -- when the tickets left is 0, the buy button no longer displays and SOLD OUT shows up. 
      
    4. Customers can buy more than one ticket for one show at a time (no shopping cart). 
      * COMPLETE -- when checking out, users can choose how many tickets they want to buy for that single movie showtime. 
      
    5. If a customer decides to buy tickets, they can checkout with name, email, CC, and expiration date (Make sure no bogus orders & No CC processor needed yet).
      * COMPLETE -- order form includes name, email, credit card/expiration and validations are in place to make sure the email format is correct and credit card meets the luhn algorithm. 
      
    6. Upon successful order completion, customer receives an email with their order (styling not needed). 
      * COMPLETE -- once an order is submitted, user receives an email with order information. 
      
    7. For admin: Order information should be saved to database. 
      * COMPLETE -- order information is saved in the orders table of the databse
      
    8. For admin: Order details should be able to be viewed. 
      * COMPLETE -- order information can be found on the '/get' orders route which also includes a dashboard of graphs. 
      
    9. Needs to work on mobile. 
      * In Process -- this is taken care of in the next section (styling)

#### Style Site & Mobile Responsiveness 
  At this time, the last piece is styling and making it work on mobile. This was taken care of using two different CSS frameworks - Bootstrap and Skeleton. These frameworks allowed for mobile responsiveness and initial site styling. Along with these, the site specific css was updated to include some color changes, images, and a favicon. 
  
  Other resources used: Font Awesome and Google Fonts
  
  Now the final requirement of working on mobile is complete.
  
  During this final step, a few more links were added to make the site more easy to navigate. I also added so that all the showtimes on the front page show up in alphabetical order by movie title and then by date and time. The front page also only shows movie showtimes that are current or in the future. If the date and time has passed, it no longer shows up on the page. However, the admin page still shows all showtimes. 
  
  The final customer process flow (not admin): 
  !['user-process'](https://github.com/kweingart08/ticket-taker/blob/master/User%20Flow%20Process.png)

   

#### Deploy to Heroku 
  The site was deployed to Heroku. Environmental variables for email confirmation were setup using the terminal, and heroku rake db:migrate was used to migrate the data tables. Heroku run rails db:seed was used to seed the database.
  
## Improvements for Later 
  
  * Date for credit card expiration -- currently the date requires a day which credit card expirations are only a month and year. This should be updated before production. 
  
  * Credit Card Processor -- use a credit card processor that does a more thorough validation and runs the credit card. 
  
  * Add a way so that when creating showtimes, it only shows the available screens and times. 
  
  * Admin Authentication -- right now anyone can go into the admin site and add movies, screens, showtimes, etc. 
  
  * If working with a team, would work off of multiple branches. This site was build on the master branch since it was just one person. 
  
  * Create a way to combine the showtimes for a movie for a specific date so that a user can filter by day and then see a movie title with all of the showtimes for that day in one spot. 
  
  * For production, remove the tickets left / tickets sold information on the showtimes SHOW page. 
  
  * Update dashboard to include labels and time of the day in a better format. 
  
  * The data would have a better way of being created. Right now a faker gem is used to seed the data and some of the times don't make sense when seeded (morning is anytime in the morning etc.).
  
  * Unique values. Right now you could add multiple movies with the same name or multiple screens with the same room_number. 

## Ruby Version and Details for Setup

* Ruby/Rails version

    - Ruby 2.3.7 
    - Rails 5.2.1

* Database creation

    - Postgres 
    - Run rails db:migrate
    - Database was created on the site. A faker gem was used to create fake data in the db/seed file. 

* Deployment instructions

    - For both deployment and development, would need to configure an email and password and save in a file or as environmental variables for the email confirmation to work. 

* Resources

    - CSS: Bootstrap, Skeleton, Google Fonts, Font Awesome 
    - Extra Gems: chartkick, figaro (used to create application.yml file and add to .gitignore), faker (used to create fake data to seed)
