//
//  DailyViewController.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/14.
//

import UIKit

class DailyViewController: UIViewController {
    
    /** @brief collectionView*/
    @IBOutlet weak var cvMain: UICollectionView!
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var lblHeartCount: UILabel!
    @IBOutlet weak var lblReplyCount: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblHashTag: UILabel!
    
    var isPlay = false
    var dailyData: [DailyModel]?
    var userIndex = 0
    var nowPage = 0
    let reelCVCell = ReelCollectionViewCell()
    var like: Int = 0
    var indexContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDailyData()
        self.cvMain.register(ReelCollectionViewCell.self, forCellWithReuseIdentifier: "ReelCollectionViewCell")
        self.cvMain.delegate = self
        self.cvMain.dataSource = self
        reelCVCell.delegate = self
    }
    
    func getReply() {
        FirestoreService().getReplyData { result in
            CommonUtil.print(output: "aaaaaaaa: \(result)")
        }
    }
    
    func getDailyData() {
        // 데이터 읽어오기 사용 예시
        FirestoreService().getDailyData() { result in
            CommonUtil.print(output: "Result of Daily : \(result)")
            self.dailyData = result
            self.cvMain.reloadData()
        }
    }
    
    func requestAddLike() {
        FirestoreService().addDailyLike(content: indexContent, like: like)
    }
    
    func overMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == (dailyData?.count ?? 0)-1 {
            // 맨 처음 페이지로 돌아감
            cvMain.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        cvMain.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    @IBAction func heartButtonTouched(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            imgHeart.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            imgHeart.tintColor = UIColor.systemPink
            like += 1
        } else {
            imgHeart.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            imgHeart.tintColor = UIColor.white // 원하는 색상으로 변경 가능
            like -= 1
        }
        // 음수 방지
        if like < 0 {
            like = 0
        }
        requestAddLike()
        lblHeartCount.text = String(like)
    }
    
    @IBAction func replyButtonTouched(_ sender: Any) {
        let vc = ReplyViewController.init(nibName: "ReplyViewController", bundle: nil)
        vc.replyData = self.dailyData
        vc.index = self.userIndex
        guard let sheet = vc.presentationController as? UISheetPresentationController else {
            return
        }
        sheet.detents = [.medium(), .large()]
        sheet.largestUndimmedDetentIdentifier = .large
        sheet.prefersGrabberVisible = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonTouched(_ sender: Any) {
        let vc = CameraViewController.init(nibName: "CameraViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
//        var objectsToShare = [String]()
//        //        if let text = textField.text {
//        //            objectsToShare.append(text)
//        //            print("[INFO] textField's Text : ", text)
//        //        }
//
//        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//        activityVC.popoverPresentationController?.sourceView = self.view
//
//        // 공유하기 기능 중 제외할 기능이 있을 때 사용
//        //        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
//        self.present(activityVC, animated: true, completion: nil)
    }
}

extension DailyViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        cell.reelData = dailyData?[indexPath.row]
        like = dailyData?[indexPath.row].like ?? 0
        indexContent = dailyData?[indexPath.row].content ?? ""
        lblHeartCount.text = String(like)
        lblContent.text = dailyData?[indexPath.row].content
        let replyCount = dailyData?[indexPath.row].reply.count ?? 0
        lblReplyCount.text = String(replyCount)
        lblHashTag.text = "#\(String(describing: dailyData?[indexPath.row].hashTag?.replacingOccurrences(of: " ", with: " #") ?? ""))"
        userIndex = indexPath.row
        FirebaseStorageManager.downloadVideo(urlString: dailyData?[indexPath.row].imageURL ?? "") { [weak self] video in
            cell.setUpPlayer(url: video!, bounds: collectionView.frame)
            if !(self?.isPlay ?? false){
                cell.avQueuePlayer?.play()
                self?.isPlay = true
            }
        }
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        cvMain.visibleCells.forEach { cell in
            let cell = cell as! ReelCollectionViewCell
            cell.avQueuePlayer?.pause()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        cvMain.visibleCells.forEach { cell in
            let cell = cell as! ReelCollectionViewCell
            cell.avQueuePlayer?.seek(to: .zero)
            cell.avQueuePlayer?.play()
        }
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ReelCollectionViewCell
        cell.avQueuePlayer?.pause()
    }
    
    
    
}
