//
//  CircularMenuTouchesDidChangeTests.swift
//  CircularMenuTests
//
//  Created by Hilal Hakkani on 08/01/2022.
//

import XCTest
import UIKit
@testable import CircularMenu

class CircularMenuTouchesDidChangeTests: XCTestCase
{

    func test_touchesDidChange_ShouldChangeIndexWhenMoving()
    {
        let sut = makeSUT()
        
        let firstQuadrant = CGPoint(x: 5, y: -5)
        let secondQuadrant = CGPoint(x: -5 , y: -5)
        let thirdQuadrant = CGPoint(x: -5, y: 5)
        let forthQuadrant = CGPoint(x: 5, y: 5)


        sut.touchesDidChange(translatedPoint:firstQuadrant)
        
        //simulating  a touch  in the first Quadrant
        XCTAssertEqual(sut.oldSelectedIndex, 0)
        
        sut.selectedMoodLayers[sut.oldSelectedIndex].lineWidth = 0
        sut.selectedMoodLayers[0].lineWidth = 3
        
        //simulating  a touch  in the second Quadrant
        sut.touchesDidChange(translatedPoint:secondQuadrant)
        
        XCTAssertEqual(sut.oldSelectedIndex, 1)
        
        sut.selectedMoodLayers[0].lineWidth = 0
        sut.selectedMoodLayers[1].lineWidth = 3
        
        //simulating  a touch  in the third Quadrant
        sut.touchesDidChange(translatedPoint:thirdQuadrant)
        XCTAssertEqual(sut.oldSelectedIndex, 2)
        sut.selectedMoodLayers[1].lineWidth = 0
        sut.selectedMoodLayers[2].lineWidth = 3
        
        
        //simulating  a touch  in the forth Quadrant
        sut.touchesDidChange(translatedPoint:forthQuadrant)
        
        XCTAssertEqual(sut.oldSelectedIndex, 3)
        sut.selectedMoodLayers[2].lineWidth = 0
        sut.selectedMoodLayers[3].lineWidth = 3

 
        
    }
    //MARK: Helpers
    func makeSUT() -> MoodView
    {
        let moodView = MoodView(frame: UIScreen.main.bounds)
        moodView.dataSource = self
        return moodView
    }
}
 

extension CircularMenuTouchesDidChangeTests: MoodViewDataSource {
    func numberOfItems() -> Int {
        return 4
    }
}
