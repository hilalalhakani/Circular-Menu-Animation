//
//  CircularMenuTouchesDidEndTests.swift
//  CircularMenuTests
//
//  Created by Hilal Hakkani on 09/01/2022.
//

import XCTest
import UIKit
@testable import CircularMenu

class CircularMenuTouchesDidEndTests: XCTestCase
{
    
    func test_touchesDidEnd_ShouldHaveScaleAnimation()
    {
        let sut = makeSUT()
        
        sut.touchDidEnd()
        
        XCTAssertNotNil(sut.layer.animation(forKey: MoodView.AnimationKeyPath.scale.rawValue))
    }
    
    func test_touchesDidEnd_InitialLayersShouldBeInInitialState()
    {
        let sut = makeSUT()
        
        sut.touchDidEnd()
        
        XCTAssertEqual(sut.initialShapeLayer.lineWidth, 3)
        XCTAssertEqual(sut.initialShapeLayer.strokeColor, UIColor.white.withAlphaComponent(0.5).cgColor)
        XCTAssertEqual(sut.initialShapeLayer.fillColor, UIColor.black.withAlphaComponent(0.7).cgColor)
        
        XCTAssertEqual(sut.whiteShapeLayer.strokeEnd, 1)
        XCTAssertEqual(sut.whiteShapeLayer.strokeStart, 0)
        
        XCTAssertEqual(sut.selectedMoodLayers[sut.oldSelectedIndex].lineWidth , 0)

    }
    
    //MARK: Helpers
    func makeSUT() -> MoodView
    {
        let moodView = MoodView(frame: UIScreen.main.bounds)
        moodView.dataSource = self
        return moodView
    }
    
}
extension CircularMenuTouchesDidEndTests: MoodViewDataSource
{
    func numberOfItems() -> Int
    {
        return 16
    }
}
