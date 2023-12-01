//
//  TimelineView.swift
//  Petmily
//
//  Created by 김지은 on 2023/11/29.
//

import UIKit

class TimelineView: UIScrollView {
    var duration: CGFloat = 0 // 비디오 전체 길이
    var currentTime: CGFloat = 0 // 현재 시간

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // 타임라인 눈금 그리기
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        context?.setStrokeColor(UIColor.blue.cgColor)

        // 간격을 나눌 수 있는 총 길이
        let totalLength: CGFloat = 1000 // 예시에서는 1000으로 가정

        // 눈금 그리기
        for i in 0..<Int(totalLength) {
            let xPos = CGFloat(i) * rect.width / totalLength
            context?.move(to: CGPoint(x: xPos, y: 0))
            context?.addLine(to: CGPoint(x: xPos, y: 20))
        }

        context?.strokePath()
    }

    func setCurrentTime(_ time: CGFloat) {
        currentTime = time
        let contentOffsetX = (currentTime / duration) * contentSize.width - bounds.width / 2
        setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: true)
    }
}
