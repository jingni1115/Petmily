import UIKit

class InfoViewController: BaseViewController, UISearchBarDelegate {
    
    
    
    // 현재 페이지
    var currentPage = 1
    // 스크롤 한 번에 로드할 데이터 개수
    let itemsPerPage = 5
    // 추가 데이터 여부
    var isMoreDataAvailable = true
    // 데이터 로딩 여부
    var isLoadingData = false
    // 검색중 여부
    var isSearching = false
    // 검색 결과를 저장할 배열
    var filteredInfoList = [InfoModel]()
    
    var infoData: [InfoModel]?
    var userData: UserModel?
    
    @IBOutlet weak var tbvInfo: UITableView!
    
    @IBOutlet weak var infoSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoData()
        setUI()
        
        tbvInfo.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getInfoData()
        setUI()
        
        tbvInfo.reloadData()
    }
    
    func getInfoData() {
        FirestoreService().getInfoData { result in
            self.infoData = result
            self.filteredInfoList = self.infoData ?? []
            print(result)
            self.getUserData()
        }
    }
    
    func getUserData() {
        FirestoreService().getUserData { result in
            self.userData = result
            print(result)
            self.tbvInfo.reloadData()
        }
    }
    
    func setUI() {
        // 테이블 뷰 설정
        tbvInfo.delegate = self
        tbvInfo.dataSource = self
        tbvInfo.register(InfoTableViewCell.self, forCellReuseIdentifier: "InfoTableViewCell")
        let nib = UINib(nibName: "InfoTableViewCell", bundle: nil)
        tbvInfo.register(nib, forCellReuseIdentifier: "InfoTableViewCell")
        
        // 서치바 설정
        infoSearchBar.delegate = self
        infoSearchBar.backgroundImage = UIImage()
        infoSearchBar.placeholder = "원하시는 동물 종을 검색해보세요"
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredInfoList = []
        } else {
            isSearching = true
            filteredInfoList = infoData?.filter { info in
                let lowercasedSearchText = searchText.lowercased()
                let titleMatches = info.title?.lowercased().contains(lowercasedSearchText) ?? false
                let contentMatches = info.content?.lowercased().contains(lowercasedSearchText) ?? false
                return titleMatches || contentMatches
            } ?? []
        }
        tbvInfo.reloadData()
    }
}





extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 출력할 셀의 개수
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredInfoList.count
        } else {
            return infoData?.count ?? 0
        }
    }
    
    // 셀 설정
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        if isSearching {
            cell.setInfo(info: filteredInfoList[indexPath.row])
        } else {
            cell.setInfo(info: infoData?[indexPath.row])
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 해제
        tbvInfo.deselectRow(at: indexPath, animated: true)
        
        // 선택한 정보 가져오기

        
        let selectedUser = userData
        
        // 목표 뷰 컨트롤러 초기화
        let vc = InfoDetailViewController.init(nibName: "InfoDetailViewController", bundle: nil)

        
        // 정보 전달
        if isSearching {
            vc.selectedInfo = filteredInfoList[indexPath.row]
        } else {
            vc.selectedInfo = infoData?[indexPath.row]
        }
        
        vc.selectedUser = selectedUser // 유저 정보
        vc.index = indexPath.row // index 정보
        navigationPushController(viewController: vc, animated: true)
    }
}


//
//    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        // 스크롤 뷰의 현재 Y 오프셋
//        let offsetY = scrollView.contentOffset.y
//
//        // 사용자가 화면을 위로 스크롤할 때만 데이터 로딩
//        if offsetY < -20 {
//            // 데이터 로딩 함수 호출
//            loadData()
//        }
//    }
