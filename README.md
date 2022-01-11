# BambooCompany

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

- There is a button on the homepage which simulates a new received message from the pubsub upon being clicked. 
- You should get a new entry into the DB with a company and a category
- For the querying service, I am simulating polling the API every 5 seconds. Uncommenting line 21 in
  application.ex will make inserts into the DB every 5 mins
- Tests are inside the `tests` folder