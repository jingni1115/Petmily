import UIKit

// 사용자 리스트를 관리하는 구조체
struct UserList {
    static var list: [User] = [
        User(image: UIImage(named: "sample6.png"), name: "박상우"),
        User(image: UIImage(named: "sample5.png"), name: "김지은"),
        User(image: UIImage(named: "잘못된 파일"),name: "박현빈"),
        User(image: UIImage(named: "sample2.png"), name: "허수빈"),
        User(image: UIImage(named: "sample9.png"),name: "최진훈")
    ]
    
    // 페이지와 페이지 당 아이템 개수를 받아 새로운 유저 데이터를 생성하는 메서드
    static func loadMoreUserData(page: Int, itemsPerPage: Int) -> [User] {
        // 실제 데이터 로드 로직이 들어가야 함!!!!
        
        // 로드한 새로운 유저 데이터를 저장할 배열
        var newUserData: [User] = []
        
        // 새 데이터를 생성할 시작 인덱스 계산
        let startIndex = (page - 1) * itemsPerPage
        
        // 시작 인덱스부터 시작해 페이지당 개수만큼의 데이터를 생성
        for i in startIndex..<(startIndex + itemsPerPage) {
            // 이미지가 있는 경우에만 UIImage 생성
            let image: UIImage? = UIImage(named: "sample\(i % 10).jpg")
            let newUser = User(image: image, name: "사용자 \(i)")
            // 새로운 User 객체를 newData 배열의 맨 앞에 추가
            newUserData.insert(newUser, at: 0)
        }
        return newUserData
    }
}
