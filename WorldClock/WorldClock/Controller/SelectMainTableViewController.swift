//
//  SelectMainTableViewController.swift
//  WorldClock
//
//  Created by arturs.zeipe on 27/06/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import UIKit

protocol ChooseMainClockProtocol {
    func changeMainClock(name: String?)
}

class SelectMainTableViewController: UITableViewController, UISearchBarDelegate {

    var locations: [String] = []
    
    @IBOutlet weak var searchText: UISearchBar!
    
    var delegate: ChooseMainClockProtocol?
    
    var name: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locations = NSTimeZone.knownTimeZoneNames
        
        searchText.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = locations[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation: String = locations[indexPath.row]
        delegate?.changeMainClock(name: selectedLocation)
        
        let alertController = UIAlertController(title: "Main clock changed!", message:
            "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }

    //MARK: - Search delegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            locations = NSTimeZone.knownTimeZoneNames.filter {$0.contains(searchText)}
        }
        else {
            locations = NSTimeZone.knownTimeZoneNames
        }
        tableView.reloadData()
    }

}
