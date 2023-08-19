//
//  ReelCollectionViewCell.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/16.
//

import UIKit
import AVKit

class ReelCollectionViewCell: UICollectionViewCell {
    
    var avQueuePlayer : AVQueuePlayer? // 일련의 플레이어 항목을 재생하는 개체
    var avplayerLayer : AVPlayerLayer? // 플레이어 개체의 시각적 콘텐츠를 나타내는 개체
    var isMuted = false
    var pause = false

    var reelData : DailyModel?
    weak var delegate: DailyViewController?
    
    let playerView : UIView = {
        let pv = UIView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        pv.isUserInteractionEnabled = true
        return pv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playerView)
//        addSubview(reelDetails)
        setUpConstrains()
        NotificationCenter.default
            .addObserver(self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: avplayerLayer
        )
        
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
//        addGestureRecognizer(longPress)
        
//        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
//        doubletap.numberOfTapsRequired = 2
//        addGestureRecognizer(doubletap)
//
//        let onetap = UITapGestureRecognizer(target: self, action: #selector(muteTap(_:)))
//        addGestureRecognizer(onetap)
        
        
//        onetap.require(toFail: doubletap) // doubleTap doesn't effect on singleTap
        
//        reelDetails.moreButton.addTarget(self, action: #selector(showAlertSheet), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPlayer(url:URL ,bounds:CGRect){
        avQueuePlayer = AVQueuePlayer(url: url)
        avplayerLayer = AVPlayerLayer(player: avQueuePlayer!)
        avplayerLayer?.frame = bounds
        avplayerLayer?.fillMode = .both // 애니메이션 시작과 끝에 어떻게 보일지 설정하는 속성
        avplayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerView.layer.addSublayer(avplayerLayer!)
    }
    
    func setUpConstrains(){
        NSLayoutConstraint.activate([
//            reelDetails.leadingAnchor.constraint(equalTo: leadingAnchor),
//            reelDetails.trailingAnchor.constraint(equalTo: trailingAnchor),
//            reelDetails.bottomAnchor.constraint(equalTo: bottomAnchor),
//            reelDetails.heightAnchor.constraint(equalToConstant: 240),
            
            playerView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            playerView.topAnchor.constraint(equalTo: playerView.topAnchor),
            playerView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
        ])
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Video Finished")
        delegate?.overMove()
    }
    
    
//    @objc func doubleTap(_ gesture : UIGestureRecognizer){
//        guard let gestureView = gesture.view else {return}
//        let size = gestureView.frame.width / CGFloat(reelData?.video?.count ?? 0)
//        let heart = UIImageView(image: UIImage(named: "white-heart"))
//        heart.frame = CGRect(x: (gestureView.frame.width-size)/2,
//                             y: (gestureView.frame.height-size)/2,
//                             width: size ,
//                             height: size)
//        gestureView.addSubview(heart)
////        self.reelData?.isLiked = true/
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn) {
//            heart.transform = .init(scaleX: 1.5, y: 1.5)
//        } completion: { finished in
//            heart.transform = .identity
//            heart.removeFromSuperview()
//        }
//
//
//        
//    }
//    
//    @objc func muteTap(_ gesture:UIGestureRecognizer){
//        isMuted = !isMuted
//        guard let gestureView = gesture.view else {return}
//        let size = gestureView.frame.width / CGFloat(reelData?.video?.count ?? 0)
//        let mute = UIImageView(image: UIImage(named: "mute"))
//        mute.tintColor = .white
//        mute.frame = CGRect(x: (gestureView.frame.width-size + 25)/2,
//                             y: (gestureView.frame.height-size + 25)/2,
//                             width: size - 25,
//                             height: size - 25)
//        
//        let unmute = UIImageView(image: UIImage(named: "unmute"))
//        unmute.tintColor = .white
//        unmute.frame = CGRect(x: (gestureView.frame.width-size + 25)/2,
//                             y: (gestureView.frame.height-size + 25)/2,
//                             width: size - 25,
//                             height: size - 25)
//                
//        if isMuted {
//            gestureView.addSubview(mute)
//            avQueuePlayer?.isMuted = true
//            UIView.animate(withDuration: 1) {
//                mute.alpha = 0
//            } completion: { done in
//                if done {mute.removeFromSuperview()
//                }
//            }
//            
//        }else {
//            gestureView.addSubview(unmute)
//            avQueuePlayer?.isMuted = false
//            
//            UIView.animate(withDuration: 1) {
//                unmute.alpha = 0
//            } completion: { done in
//                if done {unmute.removeFromSuperview()
//                }
//            }
//        }
//    }
    
//    @objc func longPressAction(_ gesture : UILongPressGestureRecognizer){
//        if gesture.state == .began {
//            avQueuePlayer?.pause()
//            delegate?.hideWhenLongTouchBegan()
//            UIView.animate(withDuration: 0.4){
//                DispatchQueue.main.async {
//                    self.reelDetails.alpha = 0
//
//                }
//            }
//        }
//        if gesture.state == .ended {
//            avQueuePlayer?.play()
//            delegate?.showWhenLongTouchEnded()
//            UIView.animate(withDuration: 0.4){
//                DispatchQueue.main.async {
//                    self.reelDetails.alpha = 1
//
//                }
//            }
//        }
//    }
    
//    @objc func showAlertSheet(){
//        delegate?.presentActionSheet()
//    }
}
