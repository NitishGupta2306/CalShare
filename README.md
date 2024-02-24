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
##### Table1 in database
- Store it in firebase as a dictonary structure. `Uid` is the `key` and the `calendarData` is the Value

#### Issue: Users connected to a Group
##### Table2 in database
- `GroupID` as a `key`. Array of `Uids` as value. All members are added to the group.

- `GroupID` stored locally on user machine.
                    
- On `re-login` or `re-download`, uid is searched against all uids in groups to restore the locally stored `groupId`


#### Issue: Forming Groups and doing computation
- Using the `GroupID` we pull each `uid` and the calendar data saved to them. 
- We then do concurrent computation of the calendars on the local machine. (Simple math, shouldnt be too intensive)

#### Issue: Date Range of information pulled
- 7 days of Calendar data. Sunday to Saturday.
- Groups auto delete in 7 days. (Unless you pay lol)

#### Issue: Max User cap:
- Since this is a to consumer application. Max user expectation is 8 people.

#### Using EventKit
You may not need to edit the Info.plist if Privacy - Calendars Full Access Usage Description
is already there then you are good.

To have the current code run you may need to edit the Info.plist file in the project. To do that all you need to do is simply add the NSCalendarsFullAccessUsageDescription key with a message like "This app needs access to your full calendar data to continue." Here are some very useful links to Apples documentation and a short video explaining how EventKit works.

Docs: https://developer.apple.com/documentation/eventkit Video/Code Examples: https://developer.apple.com/videos/play/wwdc2023/10052/?time=863

The only way I have found to be able to have the allow access pop up to re-appear is to delete the app completely and redownload it. This makes sense because the user shouldnt have to allow access everytime.

Currently there are three methods in the CalendarViewModel.
- requestAccess()

This method prompts the user to allow access to their calendar data
- fetchEvents()

This method fetches the users calendar data and updates the CalendarViewModels
events array with a sorted array of events by their start time in a specified
date range.
- hasFullAccess()

This method returns a bool indicating if the user has allowed access to their
calendar data.
