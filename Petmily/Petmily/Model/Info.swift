import UIKit

// 정보를 나타내는 구조체
struct Info {
    // 이미지 배열, nil 포함 가능한 UIImage 타입
    var images: [UIImage?]
    // 정보 식별자
    var id: Int
    // 정보 제목
    var title: String
    // 정보 설명
    var description: String
    // 정보를 작성한 사용자 이름
    var userName: String
    // 정보 작성 시간
    var time: Date
    // 정보 태그
    var tag: String
    
    // 정보에 연관된 사용자 정보를 가져오는 계산된 속성
    var user: User? {
        // UserList에서 해당 사용자의 이름과 일치하는 첫 번째 사용자를 찾아 반환
        return UserList.list.first { $0.name == userName }
    }
}
