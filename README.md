## Hot Prospects

Hot Prospects is a Swift App that allows you to scan other users QR Codes to add them as prospects that you might want to contact later on. This app was created to learn certain aspects of Swift and SwiftUI. The certain features in Swift that this app shows:

* Tab Views
* Generating QR Codes
* Scanning QR Codes
* Scheduling Local Notifications

---

### Basic Flow

The application has two main views:

* Prospects View
* Me View

---

### Prospects View
This view/tab shows all the prospects that you have scanned before. You can filter all these propsects to show everyone, ones you have contacted, and the ones you have not contacted yet. 

For each prospect you can bring up a context menu to mark it as one you have contacted or not contacted yet, and to schedule a reminder. When you schedule a reminder a notification will be scheduled to remind you to contact that certain prospect.

At the top of the Prospect View there is a Scan button that allows you to scan other prospects QR Codes, and add them as a prospect you might want to contact later on.

### Me View
This view allows you to enter in your Name and Email, and shows your unique QR Code for other people to scan your information.

---

### QR Code Scanning

Scanning a QR Code uses the library called CodeScanner, that was forked from [here](https://github.com/twostraws/CodeScanner). 