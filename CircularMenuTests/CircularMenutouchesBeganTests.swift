//
//  CircularMenuTouchTests.swift
//  CircularMenuTests
//
//  Created by Hilal Hakkani on 08/01/2022.
//

import XCTest
import UIKit
@testable import CircularMenu

class CircularMenuTouchTests: XCTestCase
{
    
    func test_touchesBegan_InitialLayersShouldChangeToDidBeganState()
    {
        let sut = makeSUT()
        
        sut.touchesDidBegan()
        
        XCTAssertEqual(sut.initialShapeLayer.fillColor, UIColor.clear.cgColor)
        XCTAssertEqual(sut.initialShapeLayer.strokeColor , UIColor.black.cgColor)
        XCTAssertTrue(sut.pickMoodLabel.isHidden)
        
    }
    
    func test_touchesBegan_ViewShouldScale()
    {
        let sut = makeSUT()
        
        
        XCTAssertEqual(.identity, sut.transform)
        
        sut.touchesDidBegan()
        
        XCTAssertEqual(CGAffineTransform(scaleX: 3, y: 3), sut.transform)
        
    }
    
    func test_touchesBegan_shouldRemoveScalingAnimation()
    {
        let sut = makeSUT()
        
        sut.touchesDidBegan()
        
        XCTAssertNil(sut.layer.animation(forKey: MoodView.AnimationKeyPath.scale.rawValue))
    }
    
    func test_touchesBegan_WhiteShapeLayerStroke(){
        
        let sut = makeSUT()
        
        let numberOfItems = sut.numberOfItems
        let oldSelectedIndex = 0
        let whiteShapeLayer = sut.whiteShapeLayer
        
        sut.touchesDidBegan()
        
        let ratio = Double(360)/Double(numberOfItems!)
        let startAngle = CGFloat(oldSelectedIndex)*ratio
        let endAngle = startAngle + ratio
        
        XCTAssertEqual(whiteShapeLayer.strokeStart, startAngle/360)
        XCTAssertEqual(whiteShapeLayer.strokeEnd, endAngle/360)
    }
    
    //MARK: Helpers
    func makeSUT() -> MoodView
    {
        let moodView = MoodView(frame: UIScreen.main.bounds)
        moodView.dataSource = self
        return moodView
    }
    
    
}

extension CircularMenuTouchTests: MoodViewDataSource {
    func numberOfItems() -> Int {
        return 4
    }
}
