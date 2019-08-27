//
//  SettingsViewController.swift
//  WorldClock
//
//  Created by arturs.zeipe on 25/06/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SaveUserDataProtocol {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeSwitch: UISwitch!
    var time24 = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - Receive user data from UserDefaults
    func saveUserData(name: String?) {
        userName.text = name
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let user = segue.destination as? EditProfileViewController {
            user.name = userName.text
            user.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let name = UserDefaults.standard.string(forKey: "userName")
        
        if name == nil || name == ""{
            userName.text = "Enter your name"
        }
        else{
            userName.text = name
        }
        imageView.image = getImage()
        
        if let timeFormat = UserDefaults.standard.value(forKey: "timeFormat"){
            timeSwitch.isOn = timeFormat as! Bool
            if timeSwitch.isOn{
                time24 = true
            }
        }
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImage()-> UIImage{
        let fileManager = FileManager.default
        let imageURL = getDocumentsDirectory().appendingPathComponent("userImage.jpg")
        let imageString = imageURL.path
        if fileManager.fileExists(atPath: imageString){
            return UIImage(contentsOfFile: imageString)!
        }else{
            return UIImage.init(named: "defaultUser")!
        }
    }

    @IBAction func timeSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "timeFormat")
        time24.toggle()
        let tabBar = tabBarController as? TabBarController
        tabBar?.time24 = time24
        UserDefaults.standard.set(time24, forKey: "timeBool")
    }
}
