//
//  ClockViewController.swift
//  WorldClock
//
//  Created by arturs.zeipe on 25/06/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController, ChooseMainClockProtocol{

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationTime: UILabel!
    var time24Bool = false
    
    // MARK: - Receive location from UserDefaults
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let location = segue.destination as? SelectMainTableViewController {
            location.name = locationName.text
            location.delegate = self
        }
    }
    
    func changeMainClock(name: String?) {
        locationName.text = name
        UserDefaults.standard.set(name, forKey: "location")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let location = UserDefaults.standard.string(forKey: "location")
//        if location == nil  || location == ""{
//           locationName.text = "Current time"
//        }
//        else{
//            locationName.text = location
//        }
        let tabBar = tabBarController as? TabBarController
        time24Bool = tabBar!.time24
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
   
    // MARK: - Loading location time
    override func awakeFromNib() {
        super.awakeFromNib()
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(setTime), userInfo: nil, repeats: true)
    }

    @objc func setTime(){
        locationTime.text = getTime()
    }

    func getTime() -> String{
        var time12 = ""
        var time24 = ""
        var time12temp = ""


        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatter.contains("a") {
            //phone is set to 12 hours
            
            // Time 12 hour format
            let formatter12 = DateFormatter()
            formatter12.timeStyle = .short
            //formatter12.timeZone = TimeZone(identifier: locationName.text!)
            let timeNow = Date()
            time12 = formatter12.string(from: timeNow)
            
            // Time 24 hour format
            let formatter24 = DateFormatter()
            formatter24.dateFormat = "h:mm a"
            let date = formatter24.date(from: time12)
            formatter24.dateFormat = "HH:mm"
            time24 = formatter24.string(from: date!)
            time12temp = time12
        } else {
            //phone is set to 24 hours
            
            // Time 24 hour format
            let formatter24 = DateFormatter()
            formatter24.timeStyle = .short
            //formatter24.timeZone = TimeZone(identifier: locationName.text!)
            let timeNow = Date()
            time24 = formatter24.string(from: timeNow)
            
            // Time 12 hour format
            let formatter12 = DateFormatter()
            formatter12.dateFormat = "HH:mm"
            let date = formatter12.date(from: time24)
            formatter12.dateFormat = "h:mm a"
            let time12 = formatter12.string(from: date!)
            time12temp = time12
        }
        
        if time24Bool{
            return time24
        }
        else{
            time12 = time12temp
            return time12
        }
    }
}
