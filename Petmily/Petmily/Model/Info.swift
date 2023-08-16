import UIKit

struct Info {
    var images: [UIImage?]
    var id: Int
    var title: String
    var description: String
    var userName: String
    var time: Date
    var tag: String
    var user: User? {
            return UserList.list.first { $0.name == userName }
        }
}
