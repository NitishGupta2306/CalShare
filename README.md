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

