//
//  ViewController.swift
//  CircularAnimation
//
//  Created by Hilal Hakkani on 18/12/2021.
//

import UIKit
import CircularMenu

class ViewController: UIViewController {
    
    @IBOutlet private weak var moodNameLabel:UILabel!
    @IBOutlet private weak var moodImageView:UIImageView!
    @IBOutlet private weak var moodBlurView:UIVisualEffectView!
    @IBOutlet private weak var moodView:MoodView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        moodView.didStart = { [weak self] in
            self?.moodBlurView.effect = UIBlurEffect(style: .dark)
        }
        
        moodView.didEnd = { [weak self] in
            self?.moodBlurView.effect = nil
        }
        
        moodView.didChangePosition = { [unowned self] index in
            let item = moodViewItems[index]
            self.moodNameLabel.text = item.text
            self.moodImageView.image = item.image
        }
        
        moodView.dataSource = self
        
    }
     
}

extension ViewController:  MoodViewDataSource
{
    func numberOfItems() -> Int
    {
        return moodViewItems.count
    }
}

