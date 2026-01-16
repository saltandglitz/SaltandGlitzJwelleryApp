# Coupon System Documentation

This document explains how coupons are applied in the Salt & Glitz e-commerce application, covering both frontend and backend implementations.

---

## Table of Contents

1. [Overview](#overview)
2. [Coupon Types](#coupon-types)
3. [Data Model](#data-model)
4. [API Endpoints](#api-endpoints)
5. [Frontend Flow](#frontend-flow)
6. [Backend Logic](#backend-logic)
7. [State Management](#state-management)
8. [User Journey](#user-journey)

---

## Overview

The coupon system allows users to apply discount codes during checkout. The system supports:
- **Promotional coupons** (NATURE10, CRAFT20) with specific discount rules
- **Referrer coupons** (REF-FIRSTNAME pattern) that give a flat 20% discount
- **SaltCash** (loyalty points) that can be applied alongside coupons

---

## Coupon Types

| Coupon Code | Type | Discount Logic |
|-------------|------|----------------|
| `NATURE10` | Promotional | 10% off diamond price (for diamonds >= 1 carat) + 20% off making charges |
| `CRAFT20` | Promotional | 20% off making charges only |
| `REF-*` | Referrer | Flat 20% off total cart value |

### Special Rules

- **NATURE10**: Requires at least one product in cart with diamond weight >= 1 carat. If no eligible product exists, the coupon is rejected.
- **Referrer Coupons**: Users cannot use their own referrer coupon code.
- **Single Coupon**: Only one coupon can be applied at a time per cart.

---

## Data Model

### Coupon Schema (`coupon.model.js`)

```javascript
{
  couponCode: String,        // e.g., "NATURE10", "CRAFT20", "REF-JOHN"
  couponContent: String,     // Description text
  couponOffer: String,       // Display text like "20% OFF"
  referrerUserId: ObjectId,  // Links to User if referrer coupon
  isReferrerCoupon: Boolean, // true for referrer coupons
  usageCount: Number         // Tracks how many times used
}
```

### Cart Schema (Coupon Fields)

```javascript
{
  appliedCoupon: {
    code: String,           // Applied coupon code
    discount: Number,       // Discount amount in rupees
    applied: Boolean,       // true if active
    isReferrerCoupon: Boolean,
    referrerUserId: ObjectId
  }
}
```

---

## API Endpoints

Base URL: `https://saltapi.stuxnet.icu/v1/coupon`

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/getCoupon` | Fetch all available promotional coupons |
| `POST` | `/applyCoupon/:userId` | Apply a coupon to user's cart |
| `POST` | `/createCoupon` | Admin: Create new coupon |
| `DELETE` | `/removeCoupon/:id` | Remove coupon from cart |

### Apply Coupon Request

```javascript
POST /v1/coupon/applyCoupon/:userId

Body: {
  couponCode: "CRAFT20"
}

Response (Success): {
  status: true,
  message: "CRAFT20 applied successfully.",
  originalTotal: 50000,
  discountAmount: 2500,
  diamondDiscount: 0,
  makingDiscount: 2500,
  referrerDiscount: 0,
  finalTotal: 47500,
  cart: {...}
}
```

---

## Frontend Flow

### 1. Cart Page (`Cart.jsx`)

The main coupon interaction happens in the cart:

```
User opens Cart
    |
    v
[Apply Coupon] button clicked
    |
    v
Modal opens showing available coupons (fetched with cart data)
    |
    v
User clicks "Redeem" on a coupon OR enters code manually
    |
    v
handleApplyCoupon() called
    |
    v
POST request to /v1/coupon/applyCoupon/:userId
    |
    +---> Success: Show success modal, update cart totals
    |
    +---> Error: Show toast error message
```

### Key Frontend Functions

#### `handleApplyCoupon(appliedCode)`
```javascript
// Location: Cart.jsx (line 537-587)

1. Get coupon code (from parameter or input field)
2. Get userId (logged-in user or guestUserId)
3. Validate both exist
4. POST to /v1/coupon/applyCoupon/:userId
5. On success:
   - Update totallPrice with finalTotal
   - Set appliedCouponData for modal display
   - Show success modal
   - Refresh cart data
6. On error:
   - Show toast error
```

#### `handleRedeemCoupon(code)`
```javascript
// Location: Cart.jsx (line 591-594)

1. Set couponCode state
2. Call handleApplyCoupon(code)
```

### 2. User Coupons Page (`Ucoupon.jsx`)

Displays available coupons in user profile:

```
User navigates to /Ucoupon
    |
    v
fetchCoupons() called on mount
    |
    v
GET /v1/coupon/getCoupon
    |
    v
Display coupon cards with "Copy Code" button
```

### 3. Order Summary (`OrderSummary.jsx`)

Displays applied discounts in checkout:

- Shows coupon discount amount
- Shows SaltCash discount separately
- Calculates final total: `totalPrice - couponDiscount - saltCashDiscount`

---

## Backend Logic

### Apply Coupon Algorithm (`coupon.controller.js`)

```
1. VALIDATE REQUEST
   - Check userId and couponCode exist
   - Validate userId format (ObjectId or UUID)

2. FETCH DATA
   - Find coupon by code
   - Find cart by userId (with populated products)
   - Find user (if logged in)

3. VALIDATION CHECKS
   - Coupon exists?
   - Cart exists?
   - Same coupon already applied?
   - Referrer trying to use own coupon?

4. CALCULATE DISCOUNT
   
   IF referrer coupon:
       discount = originalTotal * 0.20 (20%)
   
   ELSE (promotional coupon):
       FOR each item in cart:
           - Get makingCharge (based on 14KT or 18KT)
           - Get diamondWeight and diamondPrice
           
           IF couponCode is "NATURE10" or "CRAFT20":
               makingDiscount += makingCharge * 0.20 * quantity
           
           IF couponCode is "NATURE10" AND diamondWeight >= 1:
               diamondDiscount += diamondPrice * 0.10
               hasEligibleDiamond = true
       
       IF "NATURE10" AND no eligible diamond:
           REJECT with error
       
       discount = diamondDiscount + makingDiscount

5. UPDATE CART
   - Set cart.cartTotal = baseTotal - discount
   - Set cart.appliedCoupon = { code, discount, applied: true, ... }
   - Save cart

6. TRACK USAGE (for referrer coupons)
   - Increment usageCount

7. RETURN RESPONSE
   - originalTotal, discountAmount, finalTotal, cart
```

### Discount Calculation Example

**Scenario**: Cart with 1 diamond ring (1.5 carat diamond)

| Field | Value |
|-------|-------|
| Diamond Price | Rs.50,000 |
| Making Charge (14KT) | Rs.8,000 |
| Quantity | 1 |

**Applying NATURE10**:
- Diamond discount: 50,000 * 0.10 = Rs.5,000
- Making discount: 8,000 * 0.20 = Rs.1,600
- Total discount: Rs.6,600

**Applying CRAFT20**:
- Diamond discount: Rs.0 (not applicable)
- Making discount: 8,000 * 0.20 = Rs.1,600
- Total discount: Rs.1,600

---

## State Management

### Redux Store (`CartSlice.jsx`)

The cart slice manages discount state locally:

```javascript
initialState: {
  cartItems: [],
  discount: 0,           // Percentage discount (legacy)
  subtotal: 0,
  totalAmount: 0,        // subtotal - (subtotal * discount%)
  // ...
}
```

### `applyCoupon` Reducer (Legacy)

```javascript
// Handles legacy hardcoded coupons (not currently used for main flow)
applyCoupon(state, action) {
  const discountCode = action.payload;
  
  if (discountCode === "PERFECT3") discountPercent = 3;
  else if (discountCode === "SHAYAUPSELL10") discountPercent = 10;
  else if (discountCode === "MOUNT5") discountPercent = 5;
  
  state.discount = discountPercent;
  state.totalAmount = subtotal - (subtotal * discountPercent / 100);
}
```

> Note: The main coupon flow uses backend API, not this reducer. This is kept for backward compatibility.

### Local State in Cart.jsx

```javascript
const [couponDiscount, setCouponDiscount] = useState(0);     // Discount in Rs.
const [appliedCouponCode, setAppliedCouponCode] = useState(""); // Current code
const [appliedCouponData, setAppliedCouponData] = useState({
  message: "",
  code: "",
  discount: 0
});
```

---

## User Journey

### Complete Flow Diagram

```
+------------------+     +------------------+     +------------------+
|   User Profile   |     |    Cart Page     |     |  Order Summary   |
|   (/Ucoupon)     |     |    (/cart)       |     |   (/shipping)    |
+------------------+     +------------------+     +------------------+
        |                        |                        |
        |  View available        |                        |
        |  coupons, copy code    |                        |
        +----------------------->|                        |
                                 |                        |
                                 |  Click "Apply Coupon"  |
                                 |  Enter/select code     |
                                 |                        |
                                 |  POST /applyCoupon     |
                                 |        |               |
                                 |        v               |
                                 |  Backend validates     |
                                 |  and calculates        |
                                 |        |               |
                                 |        v               |
                                 |  Show success modal    |
                                 |  Update cart totals    |
                                 |                        |
                                 |  Click "Place Order"   |
                                 +----------------------->|
                                                          |
                                                          |  Show final totals
                                                          |  with all discounts
                                                          |
                                                          v
                                                    [Payment]
```

### Auto-Apply Behavior

When quantity changes (increment/decrement/remove), the frontend automatically re-applies `CRAFT20`:

```javascript
// On increment
onClick={async () => {
  await handleIncrement(item?.productId?.product_id);
  handleApplyCoupon("CRAFT20");  // Auto re-apply
}}
```

This ensures the making charge discount stays applied even when cart contents change.

---

## Error Handling

| Error | Message | Cause |
|-------|---------|-------|
| Missing data | "Missing userId or couponCode" | Empty request |
| Invalid user | "Invalid userId" | Malformed ID |
| Not found | "Coupon not found" | Invalid coupon code |
| Already applied | "Coupon already applied" | Same code used twice |
| Self-referral | "You cannot use your own referrer coupon" | User's own referrer code |
| Ineligible | "NATURE10 is only applicable on products with diamond carat above 1" | No eligible products |
| Empty cart | "Cart total is zero or invalid" | Empty cart |

---

## Files Reference

| File | Purpose |
|------|---------|
| `saltandglitz_frontend/src/Pages/Process/Cart.jsx` | Main coupon UI and application logic |
| `saltandglitz_frontend/src/UserProfile/Ucoupon.jsx` | View available coupons |
| `saltandglitz_frontend/src/Store/Slice/CartSlice.jsx` | Redux state management |
| `saltandglitz_frontend/src/Pages/Process/OrderSummary.jsx` | Display discounts in checkout |
| `saltandglitz_api/src/Controller/coupon.controller.js` | Backend coupon logic |
| `saltandglitz_api/src/Routes/v1/coupon.route.js` | API route definitions |
| `saltandglitz_api/src/Model/coupon.model.js` | Database schema |
