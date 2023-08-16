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
    
    /** @brief containerView 상단 마진*/
    @IBOutlet weak var containerTopMargin: NSLayoutConstraint!
    
    /** @brief containerView 하단 마진*/
    @IBOutlet weak var containerBottomMargin: NSLayoutConstraint!
    
    var isPlay = false
    var isMute = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout.init()
        cvMain.translatesAutoresizingMaskIntoConstraints = false
        cvMain.showsVerticalScrollIndicator = false
        layout.scrollDirection = .vertical
        
        
        cvMain.contentInsetAdjustmentBehavior = .never
        cvMain.setCollectionViewLayout(layout, animated: false)
        cvMain.register(ReelCollectionViewCell.self, forCellWithReuseIdentifier: "ReelCollectionViewCell")
        cvMain.isPagingEnabled = true
        cvMain.backgroundColor = .systemBackground
        cvMain.delegate = self
        cvMain.dataSource = self
    }
    

}

extension DailyViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var reels : [ReelData] = [ReelData(video: "demo1"), ReelData(video: "demo2"), ReelData(video: "demo3"), ReelData(video: "demo4")]
        return reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var reels : [ReelData] = [ReelData(video: "demo1"), ReelData(video: "demo2"), ReelData(video: "demo3"), ReelData(video: "demo4")]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCollectionViewCell", for: indexPath) as! ReelCollectionViewCell
        cell.reelData = reels[indexPath.row]
//        cell.delegate = self
        if let urlPath = Bundle.main.url(forResource: reels[indexPath.row].video, withExtension: "mp4"){
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
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! ReelCollectionViewCell
        cell.avQueuePlayer?.pause()
    }
    
    
    
}
