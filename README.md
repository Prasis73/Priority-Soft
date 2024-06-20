# Get Shoes

Get Shoes is an app where User can get variety of branded shoes.

## Features

- Can Register and Login.
- Simple UI to see all products.
- Products can be filtered by brands.
- Products can be filtered by price range and colors.
- User can see the reviews of the products.
- Reviews can be filtered by no of stars.
- User can add products to cart.
- Cart items can be modified later.
- User can checkout the items of the cart.

## Get Started

### Clone the code from Github

### Fetch Dependencies:

```bash
flutter pub get
```

### run the Application.

## Assumptions

### User Authentication:

Assumed basic email/password authentication using Firebase.

### Product Data:

Assumed that product data (images, names, prices, reviews, etc.) are stored in Firebase Firestore.

### Payment Integration:

Assumed that no real payment gateway integration is required.
Assumed that order creation in the database is sufficient to simulate a purchase.

## Challenges Faced and How I Overcame Them

### average rating

Challenges in calculating average ratings using Firebase Functions ( due to the Firebase rules, to use firebase function paid account is required.)
So i have added the code for the firebase function as firebase_function.js inside lib folder. and static data inside the database

### Adding data manually from Figma

also adding data from Figma to firebase manually was next challanging and boring thing for me

### infinite scroll

Infinite Scroll Implementation:

Challenge: Implementing infinite scroll for the product grid list.
Solution: Utilized the GridView.builder with a scroll controller to detect when the end of the list is reached and fetch more data.
