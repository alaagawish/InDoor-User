//
//  Constants.swift
//  InDoor-User
//
//  Created by Alaa on 08/06/2023.
//

import Foundation
class Constants {
    static let heart = "heart"
    static let fillHeart = "heart.fill"
    static let removeAlertTitle = "Removing Product"
    static let removeAlertMessage = "Are you sure to remove this product from Wishlist?"
    static let noImage = "noImage"
    static let cancel = "Cancel"
    static let yes = "Yes"
    static let brandDetails = "brandDetails"
    static let brandProduct = "brandProduct"
    static let brandCell = "brandCell"
    static let brandsNibFile = "BrandsCollectionViewCell"
    static let tShirt = "T-SHIRTS"
    static let shoes = "SHOES"
    static let accessories = "ACCESSORIES"
    static let womenID = 448451248415
    static let menID = 448451215647
    static let kidID = 448451281183
    static let saleID = 448451313951
    static let smartCollections = "smart_collections"
    static let brandProductCollectionViewCell = "BrandProductCollectionViewCell"
    static let favoritesNibName = "FavoritesCell"
    static let favoritesCellIdentifier = "favoriteCell"
    static let favoritesCellHeight = 145.0
    static let orderCellHeight = 100.0
    static let favoritesStoryboardName = "FavoritesStoryBoard"
    static let ok = "OK"
    static let nibFileName = "ShoppingCartTableViewCell"
    static let cartCellIdentifier = "cartCell"
    static let cartIdentifier = "cart"
    static let currencyPath = "currencies"
    static let addressIdentifier = "address"
    static let currencyIdentifier = "currency"
    static let connectToUsIdentifier = "connectToUs"
    static let aboutInDoorIdentifier = "aboutInDoor"
    static let addAddressIdentifier = "addAddress"
    static let cartStoryboard = "Cart"
    static let homeStoryboardName = "Home"
    static let homeIdentifier = "tabbar"
    static let signUpIdentifier = "signup"
    static let loginIdentifier = "login"
    static let no = "NO"
    static let warning = "Warning !!"
    static let invalidEmail = "Invalid Email."
    static let emailUsedBefore = "Sorry, You used this email before in registeration.\nDo you want to login?"
    static let enterAllData = "Please, Enter your data to register."
    static let firstNameIsEmpty = "Please, Enter your first name."
    static let lastNameIsEmpty = "Please, Enter your last name."
    static let emailIsEmpty = "Please, Enter your email."
    static let passwordIsEmpty = "Please, Enter your password."
    static let confirmPasswordIsEmpty = "Please, Enter password confirmation."
    static let cityIsEmpty = "Please, Enter your city."
    static let countryIsEmpty = "Please, Enter your country."
    static let addressIsEmpty = "Please, Enter your address."
    static let postalCodeIsEmpty = "Please, Enter the postal code/zip."
    static let phoneIsEmpty = "Please, Enter your phone number."
    static let passwordAndConfirmPasswordShouldBeTheSame = "Sorry, password and confirm password should be the same."
    static let registeredSuccessfully = "Congrats, you registered successfully."
    static let checkEmailAndPassword = "Invalid data\nPlease, check your email and password."
    static let emailAndPasswordCannotBeEmpty = "Please, enter your email and your password."
    static let customerId = "customer_id"
    static let invalidPassword = "Please, Enter valid Password\nMinimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character"
    static let congratulations = "Congratulations"
    static let phoneUsedbefore = "This phone number is used before."
    static let productDetailsStoryboardName = "ProductDetailsStoryBoard"
    static let settingsStoryboard = "Settings"
    static let settingsStoryboardID = "settings"
    static let ordersStoryboardID = "orders"
    static let orderCellIdentifier = "orderCell"
    static let orderNibFile = "OrderTableViewCell"
    static let getOrdersPath = "orders"
    static let brand = "brand"
    static let category = "category"
    static let mainStoryboard = "Main"
    static let passwordFormat = "SELF MATCHES %@ "
    static let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    static let customersPath = "customers"
    static let addressPath = "customers/\(UserDefault().getCustomerId())/addresses"
    static let addressCell = "addressCell"
    static let updateAddressMsg = "Do you want to update this address?"
    static let newAddressMsg = "New address is successfully added"
    static let removeAddressMsg = "Do you want to remove this address?"
    static let removeAddressTitle = "Removig address"
    static let addressCellNibFile = "AddressTableViewCell"
    static let defaultAddressMsg = "You can't delete default address"
    static let addressMsg = "Your address is already exists or there is something wrong with your data"
    static let addressUpdateTitle = "Update Address"
    static let delete = "Delete"
    static let edit = "Edit"
    static let orderCollectionViewCell = "OrderCollectionViewCell"
    static let couponChosen = "Coupon"
    static let orderStoryID = "orderStoryID"
    static let welcomeIdentifier = "welcome"
    static let reviewNibFileName = "ReviewTableViewCell"
    static let reviewCellIdentifier = "reviewCell"
    static let allReviewsIdentifier = "allReviews"
    static let selectColor = "Select color"
    static let selectSize = "Select size"
    static let shouldChooseSizeAndColorFirst = "Please, choose size and color first."
    static let removeCartItem = "This item will be removed from shopping cart"
    static let minCartItem = "This item reaches its minimum amount, you can delete it if you don't want it anymore"
    static let maxCartItem = "This item reaches its maximum amount that you can buy"
    static let orderDetails = "orderDetails"
    static let couponType = "couponType"
    static let discountAmount = "discountAmount"
    static let minSubtotal = "minSubtotal"
    static let goodReviews: [Review] = [
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrMLYoYCaldbCL4aBBfpvuxYRODSp2ty1fg&usqp=CAU", personName: "Safiya Fikry", rate: 4, reviewMessage: "I liked this product, it also look like the picture."),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrMLYoYCaldbCL4aBBfpvuxYRODSp2ty1fg&usqp=CAU", personName: "Ahd Weal", rate: 4.5, reviewMessage: "It is very comfortable product with very high quality."),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrMLYoYCaldbCL4aBBfpvuxYRODSp2ty1fg&usqp=CAU", personName: "Alaa Gawish", rate: 3.2, reviewMessage: "I recommend this product, although it is expensive."),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeQ-HkOk0nyWwdR6GNhI19KyuIDOyg-_w_tQ&usqp=CAU", personName: "Ahmed Abdo", rate: 4.1, reviewMessage: "It is worthy."),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeQ-HkOk0nyWwdR6GNhI19KyuIDOyg-_w_tQ&usqp=CAU", personName: "Ahmed Ward", rate: 3.8, reviewMessage: "Good Product.")
    ]
    static let badReviews: [Review] = [
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeQ-HkOk0nyWwdR6GNhI19KyuIDOyg-_w_tQ&usqp=CAU", personName: "Hossam Fadaly", rate: 2.2, reviewMessage: "This product is not reusable"),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrMLYoYCaldbCL4aBBfpvuxYRODSp2ty1fg&usqp=CAU", personName: "Manal Hamada", rate: 1.0, reviewMessage: "It was a bad idea to buy this product."),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrMLYoYCaldbCL4aBBfpvuxYRODSp2ty1fg&usqp=CAU", personName: "Arwa Ashraf", rate: 1.7, reviewMessage: "This product is suitable for single use."),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyrMLYoYCaldbCL4aBBfpvuxYRODSp2ty1fg&usqp=CAU", personName: "Haidy Yassin", rate: 1.3, reviewMessage: "I regret buying this product, it doesn't even worth this price"),
        Review(photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeQ-HkOk0nyWwdR6GNhI19KyuIDOyg-_w_tQ&usqp=CAU", personName: "Moaz El-sadat", rate: 2.8, reviewMessage: "At first it was good and confortable but after couple of weeks it got worse")
    ]
    static let productSearchStoryboard = "ProductSearchStoryboard"
    static let comingToSearchFrom = "comingToSearchFrom"
    static let comingToSearchFromHome = "comingToSearchFromHome"
    static let comingToSearchFromCategory = "comingToSearchFromCategory"
    static let isGoogle = "isGoogle"
    static let logoutMessage = "Are you sure to logout?"
    static let draftPath = "draft_orders"
    static let cartId = "cart_id"
    static let favoritesId = "favorites_id"
    static let putUserPath = "customers/\(UserDefaults.standard.integer(forKey: Constants.customerId))"
    static let putFavoriteDraftPath = "draft_orders/\(UserDefaults.standard.integer(forKey: Constants.favoritesId))"
    static let putCartDraftPath = "draft_orders/\(UserDefaults.standard.integer(forKey: Constants.cartId))"
    static let getFavoriteDraftPath = "draft_orders/\(UserDefaults.standard.integer(forKey: Constants.favoritesId))"
    static let getCartDraftPath = "draft_orders/\(UserDefaults.standard.integer(forKey: Constants.cartId))"
    static let directHome = "Go Home"
    static let ordersPath = "orders"
}
