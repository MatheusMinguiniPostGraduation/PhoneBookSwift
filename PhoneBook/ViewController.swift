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
    @IBOutlet weak var ddd: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var intimidade: UITextField!

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
        
        
        let enteredCountryCode = String(pais.text!)
        let enteredStateCode = String(ddd.text!)
        let enteredCellPhone = String(celular.text!)
        let celular_completo = enteredCountryCode + " " + enteredStateCode + " " + enteredCellPhone
        
        let enteredIntimacy =  String(intimidade.text!)
        let intimacyAsNumber = (enteredIntimacy as NSString).integerValue
        
        contato.setValue(celular_completo, forKey: "numero")
        contato.setValue(intimacyAsNumber, forKey: "intimidade")
        
        let enteredName = String(nome.text!)
        
        do {
            try
                
                context.save()
            
                createCustumeMessage(message: "O contato " + enteredName + " foi salvo com sucesso na base local e remota")
            } catch{
                createCustumeMessage(message: "O contato " + enteredName + " NÃO foi salvo. Por favor, retente em alguns minutos.")
            }
    }
    
    
    
    func createCustumeMessage(message : String){
        
        let alertAction = UIAlertAction( title : "Ok" ,
                                         style : .cancel) { action in
                                            (self.navigationController?.popToRootViewController(animated: true));
        }
        
        let alert = UIAlertController(title: "Aviso",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}



