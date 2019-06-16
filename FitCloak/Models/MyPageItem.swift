import Foundation

enum MyPageType: Int, Codable {
    case info = 0, faq, about
}

struct MyPageItem: Codable {
    var type: MyPageType
    var itemName: String
}
