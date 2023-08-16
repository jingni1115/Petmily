import UIKit
struct InfoList {
    // 기존 초기 데이터
    static var list: [Info] = [
        Info(images: [UIImage(named: "chichi.jpg")], id: 0, title: "치치는 귀여워요", description: "정말 귀엽답니다", userName: "박상우", time: Date(), tag: "#페르시안#친칠라#고양이"),
        Info(images: [UIImage(named: "chichi.jpg")], id: 1, title: "치치는 이뻐요", description: "정말 이쁘답니다", userName: "김지은", time: Date(), tag: "#페르시안#친칠라#고양이"),
        Info(images: [UIImage(named: "chichi.jpg")], id: 2, title: "치치는 사랑스러워요", description: "정말 사랑스럽답니다", userName: "최진훈", time: Date(), tag: "#페르시안#친칠라#고양이"),
        Info(images: [UIImage(named: "chichi.jpg")], id: 3, title: "치치는 멋져요", description: "정말 멋지답니다", userName: "박현빈", time: Date(), tag: "#페르시안#친칠라#고양이"),
        Info(images: [UIImage(named: "chichi.jpg")], id: 4, title: "치치는 똑똑해요", description: "정말 똑똑하답니다", userName: "허수빈", time: Date(), tag: "#페르시안#친칠라#고양이")
    ]

    static func loadMoreData(page: Int, itemsPerPage: Int) -> [Info] {
        // 실제로 데이터를 로드하는 로직이 이곳에 와야함!!!!!!
        
        // 로드한 새로운 데이터를 저장할 배열
        var newData: [Info] = []
        
        // 새 데이터를 생성할 시작 인덱스 계산
        let startIndex = (page - 1) * itemsPerPage
        
        // 시작 인덱스부터 시작해 페이지당 개수만큼의 데이터를 생성
        for i in startIndex..<(startIndex + itemsPerPage) {
            // 이미지가 있는 경우에만 UIImage 생성
            let image: UIImage? = UIImage(named: "sample\(i % 3).jpg")
            let newInfo = Info(images: [image],
                                id: i,
                                title: "새로운 정보 \(i)",
                                description: "새로운 정보 항목 \(i)",
                                userName: "사용자 \(i)",
                                time: Date(),
                                tag: "#새로운태그#\(i)")
            // 새로운 Info 객체를 newData 배열의 맨 앞에 추가
            newData.insert(newInfo, at: 0)
        }

        return newData
    }
}
