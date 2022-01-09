//
//  MoodViewItem.swift
//  CircularMenu
//
//  Created by Hilal Hakkani on 08/01/2022.
//

import Foundation
import UIKit

public struct MoodViewItem
{
    public let text: String
    public let image: UIImage
    
    public  init(text: String, image: UIImage)
    {
        self.text = text
        self.image = image
    }
}
