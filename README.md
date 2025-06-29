# LostAndFound

A Swift iOS app developed in Xcode demonstrating a campus Lost & Found system for Auburn University. Uses Firebase Email/Password authentication and Cloud Firestore for data storage, all organized in an MVVM architecture with SwiftUI.

## Features

- **Login** with email & password  
- **Sign Up** with email, password & confirm-password  
- **Browse** Lost vs. Found items  
- **Post** new Lost or Found items (title, description, location, date)  
- **Delete** your own items with confirmation  
- **Copy** poster’s email to clipboard with a temporary “Copied” toast  
- **Logout** with confirmation dialog  

## Architecture

- **Model**  
  - `LostFoundItem` — represents a lost or found item document in Firestore  

- **Service**  
  - `AuthenticationService` — wraps Firebase Auth calls  

- **ViewModels**  
  - `AuthViewModel` — manages authentication state  
  - `ItemsViewModel` — fetches & filters Firestore items  
  - `PostItemViewModel` — validates & posts new items  

- **Views**  
  - **Authentication**: `ContentView`, `LoginView`, `SignUpView`  
  - **Main UI**: `MainTabView`, `BrowseItemsView`, `PostItemView`, `ItemDetailView`, `AccountView`  

## Technology

- **Firebase Authentication** for secure Email/Password login, signup, and logout flows.  
- **Cloud Firestore Databasing** for real-time, scalable storage of Lost & Found items under `/items` with per-user document access.  

## Future Development

1. **Photo Attachments**  
   Allow users to attach a photo when posting an item, storing images in Firebase Storage and displaying thumbnails in the browse list.

2. **In-App Messaging & Notifications**  
   Enable direct messaging between an item's finder and owner within the app.
