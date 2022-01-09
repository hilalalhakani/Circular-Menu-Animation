//
//  CircularMenuTests.swift
//  CircularMenuTests
//
//  Created by Hilal Hakkani on 29/12/2021.
//

import XCTest
@testable import CircularMenu

class CircularMenuInitialStateTests: XCTestCase {

    func test_initialState_shouldHaveAScalingAnimation()
    {
        let sut = makeSUT()
        XCTAssertNotNil(sut.layer.animation(forKey: MoodView.AnimationKeyPath.scale.rawValue))
    }
    
    func test_initialState_AllMoodsLayersShouldBeHidden()
    {
        let sut = makeSUT()
        let layers = sut.selectedMoodLayers
        
        layers.forEach({ XCTAssertEqual($0.borderWidth , 0 )})
        layers.forEach({ XCTAssertEqual($0.fillColor, UIColor.clear.cgColor )})
        layers.forEach({ XCTAssertEqual($0.strokeColor ,UIColor.white.cgColor )})
    }
    
    func test_initialState_InitialLayersShouldBeAtInitialState()
    {
        let sut = makeSUT()
        let whiteShapeLayer = sut.whiteShapeLayer
        let initialShapeLayer = sut.initialShapeLayer
        
   
        XCTAssertEqual(initialShapeLayer.fillColor, UIColor.black.withAlphaComponent(0.7).cgColor)
        XCTAssertEqual(initialShapeLayer.lineWidth , 0)
        XCTAssertEqual(initialShapeLayer.strokeColor , nil)

        XCTAssertEqual(whiteShapeLayer.fillColor , UIColor.clear.withAlphaComponent(0.7).cgColor)
        XCTAssertEqual(whiteShapeLayer.strokeColor , UIColor.white.withAlphaComponent(0.7).cgColor)
        XCTAssertEqual(whiteShapeLayer.lineWidth , 3)
    }
     
    //MARK: Helpers
    func makeSUT() -> MoodView
    {
        let moodView = MoodView(frame: UIScreen.main.bounds)
        moodView.dataSource = self
        return moodView
    }

}
extension CircularMenuInitialStateTests: MoodViewDataSource {
    func numberOfItems() -> Int {
        return 16
    }
}
