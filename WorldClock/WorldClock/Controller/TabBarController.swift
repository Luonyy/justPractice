//
//  TabBarController.swift
//  WorldClock
//
//  Created by arturs.zeipe on 01/07/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var time24 = false

    override func viewDidLoad() {
        super.viewDidLoad()
        time24 = (UserDefaults.standard.bool(forKey: "timeBool"))
    }
}
