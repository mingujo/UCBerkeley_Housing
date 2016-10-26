## Iteration 2-1

## General situation (Finalized from our second meeting with our customer, Elissa)
	- There are, in general, three groups in this "Family Housing Scheduling" situation. They are scheduling officers who schedule a open house, CAs who shows a house to a client, and a client who is willing to look around a house.
	- All of these works are done with a single Google spreadsheet for now.
	- 1. A client calls a scheduling office, and say "I want to check the house on 11/1 08:00 AM".
	- 2. A scheduling officer checks if there is an available CA at that time, and puts the client's name on the spreadsheet.
	- 3. CA never knows either any client is assigned to him or not, so he regularly checks the spreadsheet and luckily finds out that there is a new client assigned to him.
	- 4. CA does the open house for a client.
	- 5. When it's the start of the last week of a month, all CAs go to the spreadsheet, and fill their availabilities in next month.

### Update from a customer: A customer (CA) said it would be great if they can no longer care about the spreadsheet somehow.

### Our decision: Keep the Google spreadsheet, but let CAs to use our Rails app to easily check their  schedules, and input their contact info and availabilities for next month.

### User Stories
- CA input their contact info [name, email address, phone number]
- CA input their availabilities (maybe next iteration)
- App detects any change on the spreadsheet, and send an according email to CAs

### Required functionalities
- Views for CA user interactions
- A task scheduler to fetch from Google spreadsheet periodically (maybe next iteration) 

### Cautions
- We need to make sure that CAs and scheduling officers to not change the format of spreadsheet; otherwise, our app pulls data from wrong cells and crash.
- We need to somehow keep the environment variables altogether in some separated file. 