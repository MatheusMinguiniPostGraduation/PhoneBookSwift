//
//  ContactListTableViewController.swift
//  PhoneBook
//
//  Created by pos on 27/09/2019.
//  Copyright © 2019 br.com.ifsp.minguini. All rights reserved.
//

import UIKit
import CoreData

class ContactListTableViewController: UITableViewController {

    var contacts = [NSManagedObject]()
    
    override func viewDidLoad(){
        super.viewDidLoad();
        
        contacts = retrieveDataFromCoreData()
        
        let topButton = UIButton()
        self.tableView.tableHeaderView = topButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contacts = retrieveDataFromCoreData()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contacts = retrieveDataFromCoreData()
        self.tableView.reloadData()
    }
    
    //loading the table component
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var contacts = retrieveDataFromCoreData();
        
        let cell_identifier = "contact_cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier, for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].value(forKey: "nome") as? String
        cell.detailTextLabel?.text = contacts[indexPath.row].value(forKey: "numero") as? String
        
     
        cell.imageView?.layer.cornerRadius = 25;
        cell.imageView?.clipsToBounds = true;
        
        return cell;
    }
    
    
    //Its a overloaded class which helps to perform some actions as we select a cell in the grid
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        let alert = UIAlertController(title: "Mensagem",
                                      message: "Você clicou no contato: " + contacts[indexPath.row],
                                      preferredStyle: .alert)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }*/
    
    func retrieveDataFromCoreData() -> [NSManagedObject]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contato")
        
        var contactsFromCoreData = [NSManagedObject]()
        do{
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                contactsFromCoreData.append(data)
            }
        }catch{
            print("Não foi possível recuperar os contatos salvos na base de dados")
        }
        
        return contactsFromCoreData
    }
}
