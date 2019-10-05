//
//  ViewController.swift
//  PhoneBook
//
//  Created by pos on 13/09/2019.
//  Copyright © 2019 br.com.ifsp.minguini. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var sobrenome: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func inserirContato(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let contato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into:context)
        contato.setValue(nome.text,forKey:"nome")
        contato.setValue(sobrenome.text, forKey: "sobrenome")
        
        do {
            try context.save()
            print("dados inseridos")
        } catch{
            print("dados não inseridos")
        }
        
        
    }
    
}

