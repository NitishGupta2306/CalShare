# CalShare:

Created by:
Nitish Gupta
Andrew Helbig 
Shubhada Martha
Chitra Mukherjee
Jonathan Vazquez

## Current External Documentation:

[Figma Link](https://www.figma.com/file/LdDJt5Q6lnb4CsLLT1BDb6/ECS189E-Project-UI?type=design&node-id=01&mode=design&t=z8j25F6VY80fcINF-0)

[Github Issues](https://github.com/NitishGupta2306/CalShare/issues)

## About Calshare:

Calshare is an application focused on simplifying the user experience of calendar sharing and group scheduling. Current solutions include adding multiple user calendars on Google Calendars or manually inputting free slots on When2Meet, but these options are tedious and visually overcomplicated with overlapping blocks. Our app pulls data from Apple Calendars which can be synced with Google Calendars to have access to a broader spectrum of user calendar data, and we display free event time slots between all shared events from users that join a current calendar. The main goal is to solve the complications created when scheduling using when-2-meet or Google calendars.

## Code File Structure

The main components of Calshare include our Database API, Apple Calendar API, and UI View Files.
- Nitish Gupta worked on Database integration and testing, Authentication, and Error Handling. He also worked on code clean up.
- Jonathon Vazquez worked on Database creation and integration with the app.
- Andrew Helbig worked on the Calendar API, pulling events from the user, and the calculation and display of free event time slots
- Shubhada Martin worked on the UI, the Navigation Bar, QR Code functionality, and designing the Figma
- Chitra Mukherjee worked on the UI and displaying weekly free/busy events from the EventKit Calendar data in a weekly scroll view

Files Structure:
1. General
   - ```CalShareApp.swift```
   - ```WriteViewModel.swift```
3. DatabaseAPI
   - ```AuthenticationHandler.swift```: This file handles authentication processes such as changing the password stored in the database and  creating and signing in users.
   - ```DataBaseViewModel.swift```: This file establishes accessing data from users and group IDs stored in the database.
   - ```ErrorHandling.swift```: This file contains various different error handling checks for the Group, Calendar, and Authentication.
4. CalendarAPI
   - ```CalendarViewModel.swift```: This file creates the CalendarViewModel class with functions to extract weekly calendar data (Sunday-Saturday) from the user's synced Apple Calendar. The various methods fetch and request data from the user, format the Event data, and calculate free time slots. 
5. UI_Views
   - ```CalenarContentView.swift```: This file creates the weekly header from Sunday to Saturday, displaying the CalendarView for each day on click of the header.
   - ```CalendarView.swift```: This file creates a vertical scroll day view for the week with hours from 12am to 12pm, and each event block is calculated and displayed depending on the duration of the event.
   - ```ContentViewPage.swift```: This file establishes the overall file structure with the Navigation bar allowing the user to click on the Calendar weekly view in the HomePage, GroupCreationPage, GroupsPage, and SettingsPage.
   - ```DisplayGroupQRPage.swift```: This file displays the QR code image, and gives the user the option to click and see the next available time slots. They can also navigate to 
   - ```DisplayQRPage.swift```: This page generates the QR Code, and displays the HomePage to see the available time slots in the weekly Calendar view.
   - ```GroupCreationPage.swift```: This file prompts the creation of groups by generating a QR Code for a group which multiple people will scan to be added to the same group. A scanned string returned from the CodeScannerView acts as the groupID to link users to the shared calendar.
   - ```GroupsPage.swift```: This file displays all groups the user is a part of in a List, or displays that they are no current groups added. If the user is a part of at least one group, the data for that group is pulled from the database and the free slots for this shared calendar are created. 
   - ```HomePage.swift```: The HomePage view displays the CalenarContentView page and gives the option to display the first and consequent free events from the user's calendar.
   - ```LoadingPage.swift```: The LoadingPage implements the throbber while checking whether or not a user is currently logged in. Depending on if the userAuthToken exists, we use a NavigationDestination to switch to the ContentViewPage or the SignInPage. 
   - ```SettingsPage.swift```: This file gives the user the option to logout and reset their password. If their password is not long enough, error checking is implemented. The user also has the chance to toggle between business hours and all hours for the period of time of events shown in the calendar weekly scroll view. Work hours is the time period from 9am to 5pm, whereas all hours is comprehensive.
   - ```SignInPage.swift```: This file implements user login by initializing an instance of a SignInPageViewModel() to check if the user and password entered by the user enter any existing accounts in the database. Error checking is implemented if the password does not match.
   - ```SignUpPage.swift```: This file prompts the creation of a new user account by asking for a username and password, initializing an instance of a SignUpPageViewModel to create a new user in the database and implement error checking if the email and password are not valid according to requirements such as length. There is also an option to navigate to the SignInPage if the user already has an account.
   - ```SplashScreen.swift```: This file contains the animation for our opening screen with the CalShare logo.
     
----
## How to Build the App

#### Using EventKit
You may not need to edit the Info.plist if Privacy - Calendars Full Access Usage Description
is already there then you are good.

To have the current code run you may need to edit the Info.plist file in the
project. To do that all you need to do is simply add the NSCalendarsFullAccessUsageDescription
key with a message like "This app needs access to your full calendar data to continue." 
