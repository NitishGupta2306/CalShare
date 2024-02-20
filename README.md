# CalShare:

## Current External Documentation:
Notion Link : https://www.notion.so/Current-Tasks-9d6490f15bc24970921c349a6fdfaf95?pvs=4

Figma Link : 

---
## Rules for README:
1. Keep a track of all new files inputted onto main. Keep these files in alphabetical order, as done by xcode on sort-by-name.
2. Share any external documents that document our code or process here.
3. HyperLink all file names to their description location.
4. Use highlights for the key points in description.

---
## Current CodeBase and Files:

1. [CalShareApp](#calshareapp)
2. [LandingPage](#landingpage)
3. [ReadViewModel](#readviewmodel)
4. [TesterCode](#testercode)
5. [WriteViewModel](#writeviewmodel)

### CalShareApp
- Imports `Firebase` and sets the base app configurations needed.
- Inherited `navigationStack` startpoint.

### LandingPage
- Currently empty.

### ReadViewModel
- Defines a class ReadViewModel
- Creates a reference to our database
- Creates a `readVal` function that reads data from the database given a specific `key`

### TesterCode
- File for storing any tester code that is added to the application.
- This file isnt called unless manually specified by the developer.
- Must be deleted before deploying application.

### WriteViewModel
- Defines a class WriteViewModel
- Creates a reference to our database
- Creates a `readVal` function that reads data from the database given a specific `key`

---
## Future Changes:

- Files `WriteViewModel` and `ReadViewModel` will most likely be combined into a single `DBViewModel`. This will be done when the hiearchy for the DB and the security measures have been setup.

## Using EventKit

### You may not need to edit the Info.plist if `Privacy - Calendars Full Access Usage Description` 
is already there then you are good.

To have the current code run you may need to edit the Info.plist file in the project.
To do that all you need to do is simply add the `NSCalendarsFullAccessUsageDescription` key
with a message like "This app needs access to your full calendar data to continue."
Here are some very useful links to Apples documentation and a short video explaining
how EventKit works.

Docs: https://developer.apple.com/documentation/eventkit
Video/Code Examples: https://developer.apple.com/videos/play/wwdc2023/10052/?time=863

The only way I have found to be able to have the allow access pop up to re-appear
is to delete the app completely and redownload it. This makes sense because the 
user shouldnt have to allow access everytime.
