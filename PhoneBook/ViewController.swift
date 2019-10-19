//
//  ViewController.swift
//  PhoneBook
//
//  Created by pos on 13/09/2019.
//  Copyright © 2019 br.com.ifsp.minguini. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var sobrenome: UITextField!
    @IBOutlet weak var pais: UITextField!
    @IBOutlet weak var ddd	: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var grau_intimidade: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Conexao com o Banco remoto do FireBase
        let remoteDataBase = Database.database().reference()
        remoteDataBase.child("contato").setValue(100)
    }

    @IBAction func inserirContato(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let contato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into:context)
        
        contato.setValue(nome.text,forKey:"nome")
        contato.setValue(sobrenome.text, forKey: "sobrenome")
        contato.setValue(grau_intimidade.text, forKey: "grau_intimidade")
        
        //var celular_completo = pais.text + ddd.text + celular.text
        //contato.setValue(celular_completo, forKey: "celular")
        
        do {
            try context.save()
            print("Dados inseridos")
        } catch{
            print("Dados não inseridos")
        }
        
        
    }
    
}

