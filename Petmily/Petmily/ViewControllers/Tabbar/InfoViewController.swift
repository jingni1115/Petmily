import UIKit

class InfoViewController: BaseViewController {
    
    
    // 스크롤 새로고침 관련 변수
    var currentPage = 1
    let itemsPerPage = 10
    var isMoreDataAvailable = true
    var isLoadingData = false

    @IBOutlet weak var tbvInfo: UITableView!
    
    @IBOutlet weak var infoSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvInfo.delegate = self
        tbvInfo.dataSource = self
        tbvInfo.register(InfoTableViewCell.self, forCellReuseIdentifier: "InfoTableViewCell")
        let nib = UINib(nibName: "InfoTableViewCell", bundle: nil)
        tbvInfo.register(nib, forCellReuseIdentifier: "InfoTableViewCell")
        
        
        infoSearchBar.backgroundImage = UIImage()
        infoSearchBar.placeholder = "원하시는 동물 종을 검색해보세요"
    }
    
    
}


extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    // 출력할 셀의 개수
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 셀 설정
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀 선택 해제
        tbvInfo.deselectRow(at: indexPath, animated: true)
        
        // 목표 뷰 컨트롤러 초기화
        let vc = InfoDetailViewController.init(nibName: "InfoDetailViewController", bundle: nil)
              navigationPushController(viewController: vc, animated: true)
    }
    
    public override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            loadData()
        }
    }
}
