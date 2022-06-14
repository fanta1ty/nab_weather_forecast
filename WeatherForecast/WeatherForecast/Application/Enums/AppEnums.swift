import Foundation
import UIKit

enum UserProfileType: String {
    case pendingPayment = "Chờ thanh toán",
         addUserInfo = "Thêm thông tin",
         addUserAvatar = "Thêm avatar",
         inProgress = "Đang xử lý",
         inTransport = "Đang vận chuyển",
         waitingRating = "Chờ đánh giá",
         rating = "Đánh Giá Sản Phẩm",
         purchased = "Sản Phẩm Đã Mua",
         seen = "Đã xem",
         //         favor = "Sản Phẩm Yêu Thích", // will be enable phase 2
         buyLater = "Mua sau",
         following = "Theo dõi",
         bookCare = "Bookcare",
         support = "Hỗ trợ",
         address = "Sổ địa chỉ",
         paymentInfo = "Thông tin thanh toán",
         myOrder = "Đơn Hàng Của Tôi",
         care = "Quan Tâm",
         bookingAdrress = "Địa Chỉ Nhận Hàng",
         otherUtilities = "Tiện Ích Khác",
         terms = "Quy Định Giao Dịch Chung"
}

enum FeatureTabBar {
    case bag, home, shop, favor, profile
    
    var imageName: String {
        switch self {
        case .bag: return "ic_tab_shoppingBag"
            
        case .shop: return "ic_tab_shop"
            
        case .favor: return "ic_tab_favorite"
            
        case .profile: return "ic_tab_profile"
            
        default: return "ic_tab_home"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .bag: return "ic_tab_selected_shoppingBag"
            
        case .shop: return "ic_tab_selected_shop"
            
        case .favor: return "ic_tab_selected_favorite"
            
        case .profile: return "ic_tab_selected_profile"
            
        default: return "ic_tab_selected_home"
        }
    }
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
    
    var selectedImage: UIImage? {
        return UIImage(named: selectedImageName)
    }
}
