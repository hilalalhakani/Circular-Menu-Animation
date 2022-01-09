//
//  MoodView.swift
//  CircularAnimation
//
//  Created by Hilal Hakkani on 25/12/2021.
//

import Foundation
import UIKit
 
extension MoodView {
 
    
    //MARK: Touches didBegan
    func touchesDidBegan(){
        UIView.animate(withDuration: self.animationDuration) { [self] in
            self.initialShapeLayer.fillColor = UIColor.clear.cgColor
            self.initialShapeLayer.strokeColor = UIColor.black.cgColor
            self.pickMoodLabel.isHidden = true
            self.removeScaleAnimation()
            self.transform = CGAffineTransform(scaleX: 3, y: 3)

            let angleValue = Double(360)/Double(numberOfItems)
            let startAngle = CGFloat(oldSelectedIndex)*angleValue
            let endAngle = startAngle + angleValue
            
            whiteShapeLayer.strokeStart = startAngle/360
            whiteShapeLayer.strokeEnd = endAngle/360

            self.didStart?()
         }
    }
    
    
    //MARK: Touches DidChange
    func touchesDidChange(translatedPoint: CGPoint){
         
        let v1 = CGVector(dx: translatedPoint.x , dy: translatedPoint.y )
        let v2 = CGVector(dx: arcRadius*3 , dy: 0)
        
        let angleRadians = atan2(v2.dy, v2.dx) - atan2(v1.dy, v1.dx)
        var angleDegrees = angleRadians * CGFloat(180.0 / Double.pi)
        if angleDegrees < 0 { angleDegrees += 360.0 }
        
        let index = round(angleDegrees*CGFloat(numberOfItems - 1)/360)
        print("index \(index) with Point \(translatedPoint)")
  
        self.selectedMoodLayers[oldSelectedIndex].lineWidth = 0
        self.selectedMoodLayers[Int(index)].lineWidth = 3
        
        oldSelectedIndex = Int(index)
        
        didChangePosition?(Int(index))
 
    }
    
    //MARK: Touches DidEnd
    func touchDidEnd()
    {
        UIView.animate(withDuration: self.animationDuration) { [self] in
            self.transform = .identity
            self.initialShapeLayer.lineWidth = 3
            self.initialShapeLayer.fillColor = UIColor.black.withAlphaComponent(0.7).cgColor
            self.initialShapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.5).cgColor
            whiteShapeLayer.strokeEnd = 1
            whiteShapeLayer.strokeStart = 0
            self.selectedMoodLayers[oldSelectedIndex].lineWidth = 0
            self.didEnd?()
        } completion: { _ in
            self.createScaleAnimation()
            self.pickMoodLabel.isHidden = false
        }
    }
    
}
