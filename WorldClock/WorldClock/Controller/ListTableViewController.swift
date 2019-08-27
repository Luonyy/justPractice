//
//  ListTableViewController.swift
//  WorldClock
//
//  Created by arturs.zeipe on 27/06/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import UIKit


class ListTableViewController: UITableViewController, WorldClockProtocol {

    var locationsToDisplay: [String] = []
    
    // MARK: - Receive added locations from UserDefaults
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationSegue"{
            let destination = segue.destination as! AddLocationTableViewController
            destination.delegate = self
        }
    }
    
    func addlocation(location: String) {
        locationsToDisplay.append(location)
        tableView.reloadData()
        setUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationsToDisplay = getUserDefaults()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 122
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsToDisplay.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ClockTableViewCell

        cell.locationName.text = locationsToDisplay[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            locationsToDisplay.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            setUserDefaults()
        }
    }
 
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let movedObject = self.locationsToDisplay[fromIndexPath.row]
        locationsToDisplay.remove(at: fromIndexPath.row)
        locationsToDisplay.insert(movedObject, at: to.row)
        
        tableView.reloadData()
        setUserDefaults()
    }
 
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: - Save to UserDefaults
    
    func setUserDefaults(){
        UserDefaults.standard.set(locationsToDisplay, forKey: "WorldClocks")
        UserDefaults.standard.synchronize()
    }
    
    func getUserDefaults() -> [String] {
        if UserDefaults.standard.value(forKey: "WorldClocks") != nil{
            locationsToDisplay = UserDefaults.standard.value(forKey: "WorldClocks") as! [String]
        }
        return locationsToDisplay
    }

}
