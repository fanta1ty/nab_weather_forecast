enum UrlConstant {
    
    enum General {
        public static let ApiVersion = "api/v1"
    }
    
    enum Authenticate {
        public static let register = General.ApiVersion + "/user/register"
        public static let login = General.ApiVersion + "/user/authenticate"
        public static let logout = General.ApiVersion + "/user/logout"
        public static let reset = General.ApiVersion + "/user/password/reset"
    }
    
    enum Profile {
        public static let profileDetail = General.ApiVersion + "/users/current/profile"
        public static let addAddress = General.ApiVersion + "/users/current/shipping_addresses"
        public static let updateAddress = General.ApiVersion + "/users/current/shipping_addresses/%@"
        public static let getAddress = General.ApiVersion + "/users/current/shipping_addresses"
        public static let updateProfile = General.ApiVersion + "/users/current/profile"
    }
    
    enum Caterogy {
        public static let categories = General.ApiVersion + "/categories"
        public static let products = General.ApiVersion + "/categories/%@/products"
    }
    
    enum Product {
        /// Get product details
        public static let details = General.ApiVersion + "/products/%@/"
        public static let reviews = General.ApiVersion + "/product/%@/reviews"
        public static let deals = General.ApiVersion + "/deals/suggestion/"
        public static let search = General.ApiVersion + "/products/search/"
        public static let fields = General.ApiVersion + "/products/"
        public static let productAvailable = General.ApiVersion + "/product/%@/available_qty"
    }
    
    enum Deal {
        public static let deals = General.ApiVersion + "/deals"
        public static let dealProduct = General.ApiVersion + "/deals/%@/categories/%@/products"
        
        /// Get hot deal home
        public static let hotDealHome = General.ApiVersion + "/deals/home"
    }
    
    enum Promotion {
        public static let promotion = General.ApiVersion + "/promotions"
        public static let campaign = General.ApiVersion + "/promotions/campaigns/dashboard"
        public static let bestSale = General.ApiVersion + "/promotions/best/sale"
    }
    
    enum Order {
        public static let order = General.ApiVersion + "/orders/public/"
        public static let orderHistory = General.ApiVersion + "/orders/"
        public static let orderReviewState = General.ApiVersion + "/users/current/product/reviews"
        /// Checkout cart
        public static let checkoutOrder = General.ApiVersion + "/orders/cart/checkout/"
        public static let cancel = General.ApiVersion + "/orders/%@/cancel"
    }
    
    enum Cart {
        public static let cart = General.ApiVersion + "/orders/cart"
    }
    
    enum Brand {
        public static let brand = General.ApiVersion + "/brands/"
        public static let brandTrending = General.ApiVersion + "/brands/trending"
        public static let products = General.ApiVersion + "/brands/%@/products"
    }
    
    enum Location {
        public static let location = General.ApiVersion + "/location/province/"
    }
    
    enum Prices {
        public static let prices = General.ApiVersion + "/pricelists/"
    }
    
    enum VNPay {
        public static let makePayment = General.ApiVersion + "/payment/vnpay/pay/mobile"
        public static let paymentStatus = General.ApiVersion + "/payment/vnpay/%@/status"
    }
}
