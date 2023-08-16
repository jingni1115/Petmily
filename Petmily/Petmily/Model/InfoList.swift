import UIKit
struct InfoList {
    // 기존 초기 데이터
    static var list: [Info] = [
        Info(image: UIImage(named: "chichi.jpg"), id: 0, title: "치치는 귀여워요", description: "정말 귀엽답니다", user: "박상우", time: Date(), tag: "#페르시안#친칠라#고양이"),
        Info(image: UIImage(named: "ch.jpg"), id: 0, title: "치치는 귀여워요", description: "정말 귀엽답니다", user: "박상우", time: Date(), tag: "#페르시안#친칠라#고양이"),
        Info(image: UIImage(named: "chichi.jpg"), id: 0, title: "치치는 귀여워요", description: "정말 귀엽답니다", user: "박상우", time: Date(), tag: "#페르시안#친칠라#고양이")
    ]

    static func loadMoreData(page: Int, itemsPerPage: Int) -> [Info] {
        // 실제로 데이터를 로드하는 로직이 이곳에 와야함!!!!!!
        
        // 로드한 새로운 데이터를 저장할 배열
        var newData: [Info] = []
        
        // 새 데이터를 생성할 시작 인덱스 계산
        let startIndex = (page - 1) * itemsPerPage
        
        // 시작 인덱스부터 시작해 페이지당 개수만큼의 데이터를 생성
        for i in startIndex..<(startIndex + itemsPerPage) {
            // 새로운 Info 객체를 생성하야 newData 배열의 맨 앞에 추가
            newData.insert(Info(image: UIImage(named: "sample\(i % 3).jpg"),
                                id: i,
                                title: "새로운 정보 \(i)",
                                description: "새로운 정보 항목 \(i)",
                                user: "사용자 \(i)",
                                time: Date(),
                                tag: "#새로운태그#\(i)"), at: 0)
        }

        return newData
    }
}
