## Iteration 2-2

### User Stories / Functionalities implemented in this iteration
- User Story: CA create/edit/delete their contact info [name, email address, phone number]
- User Story: App detects any change on the spreadsheet, and send an according(new schedule/cancellation) email to CAs
- Funtionality: Keep all the environment variables in one file using Figaro
- Funtionality: Let Heroku to be authorized to run Google Sheets API 
- Funtionality: Seperate production environment from Travis CI testing environment
	- add necessary environment variables to Travis CI

### Next Iteration
- CA input their availabilities (next iteration)
- Create view for Calendar/Timeslots for open house schedules
- Set up Cron, a time-based job scheduler, on Heroku