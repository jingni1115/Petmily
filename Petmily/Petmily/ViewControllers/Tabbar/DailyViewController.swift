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
    var isPlay = false
    var dailyData: [DailyModel] = []
    var nowPage = 0
    let reelCVCell = ReelCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyFirestore().getDocumentID()
        getddd()
        //        dailyData =
        //        DispatchQueue.main.asyncAfter(deadline: 1) {
        self.cvMain.register(ReelCollectionViewCell.self, forCellWithReuseIdentifier: "ReelCollectionViewCell")
        self.cvMain.delegate = self
        self.cvMain.dataSource = self
        //        }
        reelCVCell.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cvMain.reloadData()
        
    }
    
    func getddd() {
        // 데이터 읽어오기 사용 예시
        MyFirestore().fetchUserData { names in
            print("Fetched names: \(names)")
            self.dailyData = names ?? []
            self.cvMain.reloadData()
        }
    }
    
        func overMove() {
            // 현재페이지가 마지막 페이지일 경우
            if nowPage == dailyData.count-1 {
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
        imgHeart.image = sender.isSelected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    @IBAction func replyButtonTouched(_ sender: Any) {
        let vc = ReplySheetViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func shareButtonTouched(_ sender: Any) {
        var objectsToShare = [String]()
//        if let text = textField.text {
//            objectsToShare.append(text)
//            print("[INFO] textField's Text : ", text)
//        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        // 공유하기 기능 중 제외할 기능이 있을 때 사용
        //        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension DailyViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let doc = MyFirestore().getDocuments()
        return dailyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reels = MyFirestore().getDocuments()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        cell.reelData = dailyData[indexPath.row]
        if let urlPath = Bundle.main.url(forResource: dailyData[indexPath.row].imageURL, withExtension: "mp4"){
            cell.setUpPlayer(url: urlPath, bounds: collectionView.frame)
            if !isPlay{
                cell.avQueuePlayer?.play()
                isPlay = true
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
        //        MyFirestore().addData()
        
        
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
