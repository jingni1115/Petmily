//
//  BasdViewController.swift
//  PetUI
//
//  Created by t2023-m0049 on 2023/08/16.
//

import UIKit

class AddViewController: UIViewController {

    
    /** @brief 뷰1*/
    @IBOutlet weak var view1: UIView!
    
    /** @brief 뷰2*/
    @IBOutlet weak var view2: UIView!
    
    
    /** @brief 세그먼트버튼*/
    @IBOutlet weak var segBtn: UISegmentedControl!
    
    
    /** @brief 정보공유콘텐츠플레이스홀더*/
    @IBOutlet weak var lblPlaceholder: UILabel!
    
    
    /** @brief 정보공유해시태그*/
    @IBOutlet weak var hashTag: UITextField!//정보공유해시태그
   

    /** @brief 정보공유콘텐츠창*/
    @IBOutlet weak var txtvContents: UITextView!//정보공유콘텐츠창
    
    /** @brief 정보공유제목*/
    @IBOutlet weak var infoTitle: UITextField!//정보공유제목
    
    
    /** @brief 데일리 해시태그*/
    @IBOutlet weak var hasTag: UITextField!//데일리 해시태그
    
    /** @brief 데일리 간단한 설명글*/
    @IBOutlet weak var shortTxtF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtvContents.delegate = self
    }
//액션 이쪽으로 옮길것
    
    @IBAction func plusBtn(_ sender: UIButton) {
        //+버튼 눌렀을 때 갤러리가 뜨게해야한다(사진이나 동영상 첨부를 위해서)
    }
    
    
    
    @IBAction func segBtn(_ sender: UISegmentedControl) {
        //세그먼트버튼 눌렀을 때 뷰끼리의 화면전환을 알파값으로 구현 실패
        if sender.selectedSegmentIndex == 0 {
            view1.isHidden = false
            view2.isHidden = true
        } else {
            view1.isHidden = true
            view2.isHidden = false
            
        }
        
    }
    
  
    @IBAction func uploadBtn(_ sender: UIButton) {
        //업로드 버튼 눌렀을 때 갤러리로 이동
    }
    

    
    
    
}

extension AddViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblPlaceholder.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        lblPlaceholder.isHidden = !txtvContents.text.isEmpty
    }
    
    
}

