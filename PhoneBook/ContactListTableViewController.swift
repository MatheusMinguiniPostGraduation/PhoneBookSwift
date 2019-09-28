//
//  ContactListTableViewController.swift
//  PhoneBook
//
//  Created by pos on 27/09/2019.
//  Copyright © 2019 br.com.ifsp.minguini. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    var contacts : [String] = ["Matheus", "Luis", "Cleiton"]
    
    
    override func viewDidLoad(){
        super.viewDidLoad();
        
        let topButton = UIButton()
        self.tableView.tableHeaderView = topButton
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
        cell.detailTextLabel?.text = "99706 - 3747"
      
        
        cell.imageView?.layer.cornerRadius = 25;
        cell.imageView?.clipsToBounds = true;
        
        return cell;
    }
    
    //Its a overloaded class which helps to perform some actions as we select a cell in the grid
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        let alert = UIAlertController(title: "Mensagem",
                                      message: "Você clicou no contato: " + contacts[indexPath.row],
                                      preferredStyle: .alert)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
        
            let button = UIButton()
            button.frame = CGRect(x: 20, y: 5, width: 300, height: 60)
            button.setTitle("Lista de contatos", for: .normal)
        
            headerView.addSubview(button)
            return headerView
        
    }
}
