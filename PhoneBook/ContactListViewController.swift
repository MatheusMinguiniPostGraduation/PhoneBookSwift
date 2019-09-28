//
//  ContactListController.swift
//  PhoneBook
//
//  Created by pos on 27/09/2019.
//  Copyright © 2019 br.com.ifsp.minguini. All rights reserved.
//

import UIKit

class ContactListViewController: UITableViewController {

    var contacts : [String] = ["Matheus", "Luis", "Cleiton"]
    
    
    override func viewDidLoad(){
        super.viewDidLoad();
    }
    
    
    //loading the table component
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell_identifier = "contact_cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier, for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row]
        
        
        cell.imageView?.layer.cornerRadius = 25;
        cell.imageView?.clipsToBounds = true;
        
        return cell;
    }

}
