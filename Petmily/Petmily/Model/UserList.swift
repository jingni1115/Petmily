import UIKit

// 사용자 리스트를 관리하는 구조체
struct UserList {
    // 초기 데이터 리스트
    static var list: [User] = [
        // 초기 더미 데이터를 생성하여 list 배열에 추가
        User(image: UIImage(named: "danjy.jpg"), name: "박상우"),
        User(image: UIImage(named: "danjy.jpg"), name: "김지은"),
        User(name: "박현빈"),
        User(image: UIImage(named: "danjy.jpg"), name: "허수빈"),
        User(name: "최진훈")
    ]
}

