//
//  MoodView+LifeCyle.swift
//  CircularAnimation
//
//  Created by Hilal Hakkani on 25/12/2021.
//

import Foundation
import UIKit

public protocol MoodViewDataSource {
    func numberOfItems() -> Int
}
public class MoodView: UIView {
    
    public var didStart:(()-> Void)?
    public var didEnd:(()-> Void)?
    public var didChangePosition:((Int)-> Void)?
    
    //Layers
    let initialShapeLayer = CAShapeLayer()
    let whiteShapeLayer = CAShapeLayer()
    var selectedMoodLayers = [CAShapeLayer]()

    
    var centerPoint:CGPoint!
    
    public var dataSource: MoodViewDataSource! {
        didSet {
            setup()
        }
    }
    
    public var numberOfItems: Int! {
        dataSource.numberOfItems()
    }
    let arcRadius:CGFloat = 50
    
    var oldSelectedIndex:Int = 0

    enum AnimationKeyPath: String { case scale = "transform.scale" }
    
    lazy var  pickMoodLabel:UILabel = {
        let label = UILabel()
        label.text = "Pick \n Mood"
        label.numberOfLines = 2
        label.font = UIFont(name: "GTEestiProDisplay-Bold", size: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
     var animationDuration: Double  {
        if self.isRunningTest() {
            return 0.0
        } else {
            return 0.5
        }
    }
 
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    func setup()
    {
        createScaleAnimation()
        createGestures()
        setupLabel()
        setupLayers()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        centerPoint = CGPoint(x: self.bounds.width/2 , y: self.bounds.height/2)
        let initialCirclePath = UIBezierPath(
            arcCenter: centerPoint,
            radius: arcRadius,
            startAngle: deg2rad(0),
            endAngle:deg2rad(360),
            clockwise: false)
        
        let whiteCirclePath = UIBezierPath(
            arcCenter: centerPoint,
            radius: arcRadius+2,
            startAngle: deg2rad(0),
            endAngle:deg2rad(360),
            clockwise: false)
        
        
        initialShapeLayer.path = initialCirclePath.cgPath
        whiteShapeLayer.path = whiteCirclePath.cgPath
        
        
        //Setup the N Layers
        let ratio = (CGFloat(360)/CGFloat(selectedMoodLayers.count))
        var startAngle:CGFloat = 0
        var endAngle:CGFloat = startAngle + ratio

        for (selectedLayer) in selectedMoodLayers {

            let selectedCirclePath = UIBezierPath(
                arcCenter: centerPoint,
                radius: arcRadius+2,
                startAngle: -deg2rad(startAngle),
                endAngle: -deg2rad(endAngle) ,
                clockwise: false)
            
            startAngle = endAngle
            endAngle = endAngle + ratio
            
            selectedLayer.path = selectedCirclePath.cgPath

            selectedLayer.lineWidth = 0
             
        }
        
        
    }
  
}
