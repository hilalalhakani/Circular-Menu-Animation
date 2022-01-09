//
//  MoodView+Helpers.swift
//  CircularAnimation
//
//  Created by Hilal Hakkani on 25/12/2021.
//

import Foundation
import UIKit

extension MoodView {
    
    func setupLabel(){
        self.addSubview(pickMoodLabel)
        pickMoodLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pickMoodLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func createGestures(){
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(monitorTouch))
        panGestureRecognizer.delegate = self
        self.addGestureRecognizer(panGestureRecognizer)
        
        let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(monitorTouch))
        longGestureRecognizer.delegate = self
        self.addGestureRecognizer(longGestureRecognizer)
    }
    
    @objc func monitorTouch(sender:UIGestureRecognizer) {
        if sender.state == .began {
            touchesDidBegan()
        } else if sender.state == .changed {
            guard (sender as? UIPanGestureRecognizer != nil) else { return }
            let translatedPoint: CGPoint =  (sender as! UIPanGestureRecognizer).translation(in: self.superview)
            touchesDidChange(translatedPoint: translatedPoint)
        } else if sender.state == .ended {
            touchDidEnd()
        }
    }
    
    
    
    func setupLayers(){
        initialShapeLayer.fillColor = UIColor.black.withAlphaComponent(0.7).cgColor
        initialShapeLayer.lineWidth = 0
        layer.insertSublayer(initialShapeLayer, at:0)
        
        whiteShapeLayer.fillColor = UIColor.clear.withAlphaComponent(0.7).cgColor
        whiteShapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.7).cgColor
        whiteShapeLayer.lineWidth = 3
        layer.insertSublayer(whiteShapeLayer, at:0)
        
        for _  in 0 ..< numberOfItems {
            let selectedLayer = CAShapeLayer()
            selectedLayer.fillColor = UIColor.clear.cgColor
            selectedLayer.strokeColor = UIColor.white.cgColor
            selectedLayer.lineWidth = 0
            
            layer.addSublayer(selectedLayer)
            
            selectedMoodLayers.append(selectedLayer)

        }
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    

    //MARK: Setup Scale Animation
    
    func createScaleAnimation() {
        let scale = CABasicAnimation(keyPath: AnimationKeyPath.scale.rawValue)
        scale.duration = 1
        scale.fromValue = 1
        scale.toValue = 1.15
        scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        scale.autoreverses = true
        scale.repeatCount = .greatestFiniteMagnitude
        layer.add(scale, forKey: AnimationKeyPath.scale.rawValue)
    }
    
    func removeScaleAnimation() {
        self.layer.removeAnimation(forKey: AnimationKeyPath.scale.rawValue)
    }
    
    func isRunningTest() -> Bool
    {
        if let _ = NSClassFromString("XCTest") {
            return true
        } else {
            return false
        }
    }
}

extension MoodView:UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
