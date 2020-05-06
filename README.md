LifeLine - README 
===

## Lifeline, the line to stay connected with the important people in your life

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
LifeLine is an app where users are able to see where groups of people are on a map and be alerted if they have been in a accident. The app allows for group admins to set restrictions for group members such as geofencing and speeding.

### App Evaluation

- **Category: Lifestyle** 
- **Mobile: iOS android to come soon**
- **Story: See where your friends and family are**
- **Market: Familes, companies and friends can all use this app to see where each other are and how they are driving**
- **Habit: This app runs in the background and you would open it to see where someone is or check alerts of someone driving too fast or getting into an accident**
- **Scope: We are aiming this at all age groups. Families  can use this to keep track of teens and elder family members. Companies can use this to keep track of delivery workers to hold people accountable. Our main goal is to be the preferred driving behavior and location app**

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* [x] As someone with multiple phones I want to be able to create an account so that I can use the application from different devices.
* [x] As someone who wants to change phones I want to be able to change my account phone number so that I can keep the groups associated with that account.
* [x] As a group member I want to see my group geofences in a map view so that I can abide by them.
* [x] As a dad I want to know when my child leaves the curfew radius so that I know if they're going somewhere they shouldn't.
* [x] As a mom I want to know where my children are on the map so that I know they got to the destination safe.
* [x] As a friend I want to see when my friends are speeding so that I can tell them to drive responsibly.

**Optional Nice-to-have Stories**
* [x] As a regular user I want a profile settings options so that I can customize my profile.
* [ ] As a parent I want to be notified if my child is texting and driving so I can tell them not to text and drive.
* [ ] As a business owner I want to be alerted when my delivery driver goes off route so I can make sure my drivers are working.
* [ ] As a granddaughter I want to see when my grandmother's phone is on low batery so I can remind her to charge it.

### 2. Screen Archetypes
* Login Screen
   * User can sign up 
   * User can log in
* Account Settings Screen
   * User can edit their account information
   * User can log out
   * User can delete their account
* Groups Screen
   * User can create groups
   * User can invite other users 
   * User can edit other users' roles
   * User can edit groups
* Maps Screen
    * User can see people on the map
    * User can filter by group

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Groups tab
* Settings tab
* Map tab

**Flow Navigation** (Screen to Screen)
* Signup/SignIn screen; Displays logo with splash page. Ability to SignUp for service or Log in to an account.
* User Profile screen; Displays user information with profile image, countdown timer edit function, and user contacts editing    function.
* Map screen; Displays current location of user. With Search function, user can locate those in their contacts list.
* Countdown screen; Countdown appears after a sufficient impact, and will cycle down then alert those nearby for assitance unless the stop button is used to negate the countdown.

## Wireframes
<p float="left">
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_SignUp_SignIn.png" width=100>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_Profile_Contacts.png" width=100>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_MapDisplay.png" width=100>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_Countdown.png" width=100>
</p>

**[BONUS] Digital Wireframes & Mockups**
<br><img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/wireframe.png" width=250><br>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LifeLine.gif" width=250><br>

https://www.figma.com/proto/jE3KKpTsZBvMxOezelbsN7/LifeLine?node-id=19%3A3&scaling=scale-down

## Schema 
### Models
Strings, Images, and Dictionaries to send information.
Dictionaries to recieve information.

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | User       | Dictionary | User information |
   | Name          | String   | User display name|
   | Phone Number  | String   | User phone number|
   | Image         | Png      | User display image |
   | Groups        | Dictionary | Groups the user is in |
   | Group Members       | Dictionary | Members of a group |
   
### Networking
- Post user information functions: Windows Server 2019 on AWS, PHP & MySQL
- Read user information functions: Windows Server 2019 on AWS, PHP & MySQL
- Post group information functions: Windows Server 2019 on AWS, PHP & MySQL
- Read group information functions: Windows Server 2019 on AWS, PHP & MySQL
- Post zone information functions: Windows Server 2019 on AWS, PHP & MySQL
- Read zone information functions: Windows Server 2019 on AWS, PHP & MySQL
- http://ec2-54-241-187-187.us-west-1.compute.amazonaws.com/lifeline/testapi.html

## Video Walkthrough
Here's a walkthrough of implemented user stories: <br><br>
<img src='https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/readmeGif.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />
<img src='http://g.recordit.co/QLicfzrm4H.gif' title='Video Walkthrough' width='190' height='370' alt='Video Walkthrough' />
<img src='http://g.recordit.co/0i1wQuBP8U.gif' title='Video Walkthrough' height='370' alt='Video Walkthrough' />
<img src='http://g.recordit.co/CbaZJ9yagF.gif' title='Video Walkthrough' height='370' alt='Video Walkthrough' />
