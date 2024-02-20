# CalShare:

## Current External Documentation:
Notion Link : https://www.notion.so/Current-Tasks-9d6490f15bc24970921c349a6fdfaf95?pvs=4

Figma Link : https://www.figma.com/file/LdDJt5Q6lnb4CsLLT1BDb6/ECS189E-Project-UI?type=design&node-id=16-8&mode=design&t=PvkUh4eFckq1UKwL-0

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
