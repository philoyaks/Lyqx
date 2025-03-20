# lyqx Project

# Fake Store App

## Overview
This project is an E-Commerce app built with Flutter as part of a developer test task. The application leverages the Fake Store API to showcase an end-to-end shopping experience, including:
- Product listing
- Product details
- Cart management
- Wishlist feature (optional)

## Features
### **User Authentication (Login)**
- Secure login with field validation and password visibility toggle.

### **Product Listing**
- Fetches and displays products using lazy loading with infinite scroll.
- Displays product image, name, price, and rating.

### **Product Details**
- Detailed view of selected products, including full description, category, and rating.
- Add-to-cart functionality.

### **Cart Management**
- Add or remove products from the cart.
- View cart total price.

### **Wishlist (Local Storage)**
- Add/remove products to/from the wishlist.
- View wishlist items stored locally using SharedPreferences.

## Tech Stack
- **State Management:** BLoC
- **Dependency Injection:** Injectable & Get_it
- **API Calls:** Dio
- **Local Storage:** SharedPreferences
- **Routing:** GoRoute


## Installation and Setup
### **Clone the repository:**
```sh
git clone https://github.com/philoyaks/Lyqx.git
cd Lyqx
```

### **Install dependencies:**
```sh
flutter pub get
```

### **Generate injectable dependencies:**
```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

### **Run the application:**
```sh
flutter run
```

## API Usage
The application uses the **Fake Store API** for authentication, product, and cart data:
- The login API authenticates users.
- The product API fetches product details.
- The cart API manages cart operations.

## How to Use
1. Launch the app and navigate to the login screen.
2. Enter credentials (e.g., `username: johnd`, `password: m38rmF$`).
3. Browse products, view details, and add items to your cart.
4. Manage your cart and view the total price.
5. Add and remove products from your wishlist.

## Estimated Time to Complete
The estimated time for completing the project is approximately **11 hours and 10 mins**, according to WakaTime between  20th-21st march, 2025.
<img width="1010" alt="Screenshot 2025-03-20 at 9 45 10 AM" src="https://github.com/user-attachments/assets/c01441cf-51a9-4261-93a5-4521d591125e" />

##Loom Video Link
[Click here to Open](https://www.loom.com/share/db10ebe3d4c244b08caa53c74ade8ec2?sid=3163f8a2-0bf9-4b9b-b872-8b57c590c0b0)

## License
This project is licensed under the **MIT License**.
