//
//  Date+Extension.swift
//  AnalogClock
//
//  Created by arturs.zeipe on 28/06/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import Foundation

extension Date {
    var dateComponents: DateComponents {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponenets = calendar.dateComponents([.year, .month, .day, .second, .minute, .hour], from: self)
        return dateComponenets
    }
    var second: NSInteger {
        return dateComponents.second ?? 0
    }
    var minute: NSInteger {
        return dateComponents.minute ?? 0
    }
    var hour: NSInteger {
        return dateComponents.hour ?? 0
    }
}
