LifeLine - README 
===

## Lifeline, stay connected with the people in your life

### Video Walkthrough
<br>
<img src='http://g.recordit.co/jzT2f3zDUw.gif' title='Video Walkthrough' width='300' alt='Video Walkthrough' />

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

### 1. User Stories
* As someone with multiple phones, I want to be able to create an account so that I can use the application from different devices.
* As someone who wants to change phones, I want to be able to change my account phone number so that I can keep the groups associated with that account.
* As a member of a team, I want to see my team's geofences in a map view so that I can abide by them.
* As a dad, I want to know when my child leaves the curfew radius so that I know if they're going somewhere they shouldn't.
* As a mom, I want to know where my children are on the map so that I know they got to the destination safe.
* As a friend, I want to see when my friends are speeding so that I can tell them to drive responsibly.
* As a regular, user I want a profile settings options so that I can customize my profile.

### 2. Screen Archetypes
* Login Screen
  * Sign in 
  * Sign Up
  * Forgot Password
* Account Settings Screen
  * Edit account information
  * Sign out
  * Delete account
* Groups Screen
  * Create group
  * View groups 
* Group Screen
  * View group members
  * Locate group member on map
  * Edit other users' roles
  * Group Chat
  * Invite members
* Group Settings Screen
  * Edit group information
  * Leave/Delete group
* Chat Screen
  * View messages and alerts
  * Send messages

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

## Wireframe
<p float="left">
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_SignUp_SignIn.png" width=100>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_Profile_Contacts.png" width=100>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_MapDisplay.png" width=100>
<img src="https://github.com/GroupAlert/LifeLine/blob/master/ReadMe%20Assets/LL_Countdown.png" width=100>
</p>

## Schema 
### Models
<img src="https://github.com/pv-gitjob/LifeLine/blob/master/Readme%20Assets/DB%20Design.png" width=500>
   
### Networking
- AWS EC2 Instance
  - Windows Server 2019, PHP & MySQL
- http://praveenv.org/lifeline/testapi.html
