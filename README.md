# CalShare:

## Current External Documentation:

[Figma Link](https://www.figma.com/file/LdDJt5Q6lnb4CsLLT1BDb6/ECS189E-Project-UI?type=design&node-id=01&mode=design&t=z8j25F6VY80fcINF-0)

[Github Issues](https://github.com/NitishGupta2306/CalShare/issues)

---
## Rules for README:
1. Keep a track of all new files inputted onto main. Keep these files in alphabetical order, as done by xcode on sort-by-name.
2. Share any external documents that document our code or process here.
3. HyperLink all file names to their description location.
4. Use highlights for the key points in description.

---

## Current Issues + Ideas:

#### Issue: Storing uid : calendarData
##### UserData Table For database
- Store it in firebase as a dictonary structure. `Uid` is the `key` and the `calendarData` is the Value

|  UserID  |    [CalendarData]    |
|----------|----------------------|
|d324bbn423|[(startTime1, endTime1),(startTime2, endTime2)]|

- UserID will be the user's ID that they get when they sign in/create account

- The Calender Data is a variable array that stores tuples where the first element in the tuple is the start time of an event and the 2nd element of the tuple is the end time of an event. No need to store any more information like the name of the event because it will not be displayed anyways.

- The times will be stored as 64 Bit integers representing their time in Unix time(sec since Jan 1, 1970) so that the memory load is relatively small. On the user side, these ints will be converted to a readable date format.


#### Issue: Users connected to a Group
##### Group Table for Database
- `GroupID` as a `key`. Entries of `Uids` as value. All members are added to the group.
- Have an extra entry for `NumOfUsersInGroup`

|   GroupID  |NumOfUsersInGroup| UserID0 | UserID1 | UserID2 | UserID3 | UserID4 | UserID5 | UserID6 | UserID7 |
|------------|-----------------|---------|---------|---------|---------|---------|---------|---------|---------|
|RandomString|        3        |d544bhn42|d32dfbn42|d390jmn78|         |         |         |         |         |

- To get what get what group a user in, just search through UserID0-7 and see if their userID is in that row. If it is then return that groupID to the user. Should be fairly simple and quick using a SQL query.

- Will need a way of generating **unique** GroupID's. One possible way is generate random string and check if it already exists in the table. If it does not then, use that string. If it already exists then generate another and check again. Reason for doing it this way is so that people cant try to get consecutive groupID's by just increasing the last char.

- `GroupID` stored locally on user machine.
                    
- On `re-login` or `re-download`, uid is searched against all uids in groups to restore the locally stored `groupId`


#### Issue: Forming Groups, event computation, and general flow
1. Getting userData flow
  * Get userID from user by either signing in or from device(previous sign in)
  * Get the groups a user is in by searching the Group Table
  * Once user has the groupID's they are in, then also retreive all the userIDs that are in every group from the Group Table. 
  * When selecting a group on user side, retrieve all the data from every user in that group from the UserData Table. Every user should have their information in that table if they signed in.
 
2. We then do concurrent computation of the calendars on the local machine. (Simple math, shouldnt be too intensive)

3. For adding people to groups, will just need to share the groupID to the user's who want to join and then add them to the row of that GroupID in the Group Table.
  * To make it work with QRCodes, will need to have it open up app (or send to appStore to download) and then do the group join feature with the provided groupID. Maybe use a query string in url to store groupID???
4. For this to work, cannot save the group data and user data before hand. Will have to refetch the data on every open so that it is not desynced. However a user's UserID will never change so that can be stored on the device if the user has signed in before.

#### Issue: Date Range of information pulled
- 7 days of Calendar data. Sunday to Saturday.
- Groups auto delete in 7 days. (Unless you pay lol). Will need to add a date of the time the group was created for this to work to the Group Table

#### Issue: Max User cap:
- Since this is a to consumer application. Max user expectation is 8 people.

#### Using EventKit
You may not need to edit the Info.plist if Privacy - Calendars Full Access Usage Description
is already there then you are good.

To have the current code run you may need to edit the Info.plist file in the
project. To do that all you need to do is simply add the NSCalendarsFullAccessUsageDescription
key with a message like "This app needs access to your full calendar data to continue." 
Here are some very useful links to Apples documentation and a short video 
explaining how EventKit works.

Docs: https://developer.apple.com/documentation/eventkit Video/Code Examples: https://developer.apple.com/videos/play/wwdc2023/10052/?time=863

The only way I have found to be able to have the allow access pop up to 
re-appear is to delete the app completely and redownload it. 
This makes sense because the user shouldnt have to allow access everytime.

##### CalendarViewModel

Currently there are four methods in the CalendarViewModel.
- requestAccess()

This method prompts the user to allow access to their calendar data
- fetchEvents()

This method fetches the users calendar data and updates the CalendarViewModels
events array with a sorted array of events by their start time in a specified
date range.

- fetchCurrentWeekEvents()

This method is exactly the same as the above one except it has some pre filled
in values and makes interacting with the api smoother since we know we only 
want the current weeks events.
- hasFullAccess()

This method returns a bool indicating if the user has allowed access to their
calendar data.

##### EventListView

This file contains a bare bones ui implementation of how to interact with the
CalendarViewModel on the UI side. Each event is layed out in a scrolling view
and the dates are formatted using a simple formatting function. The goal here
is to make interacting with and displaying calendar data as simple and easy
as possible.

The EventListView relies on having access to an instance of the CalendarViewModel.
on my example branch I created an environment object on the homescreen. Below
is a link to the branch used for testing the api and views together.
https://github.com/NitishGupta2306/CalShare/tree/updated-calendar-api
