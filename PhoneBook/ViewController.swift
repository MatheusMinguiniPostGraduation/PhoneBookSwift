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
    
    var contato : Contato!
    var isEditar : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(contato != nil) {
            nome.text = contato.nome
            sobrenome.text = contato.sobrenome
            intimidade.text = String(contato.intimidade)
            celular.text = contato.numero
            self.isEditar = true
        }
    }
    
    @IBAction func inserirContato(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let success : Bool
        
        if(self.isEditar){
            success = editar(appDelegate : appDelegate);
        }else{
            success = salvar(appDelegate: appDelegate);
        }
        
        if(success){
            createCustumeMessage(message: "O contato " + nome.text! + " foi registrado com sucesso na base local e remota")
        }else{
            createCustumeMessage(message: "O contato " + nome.text! + " NÃO foi registrado. Por favor, retente em alguns minutos.")
        }
    }
    
    func salvar(appDelegate : AppDelegate) -> Bool{
        let context = appDelegate.persistentContainer.viewContext
        let contato = NSEntityDescription.insertNewObject(forEntityName: "Contato", into:context)
        
        setContatoValues(contatoBD: contato)
        
        do {
            try context.save()
        } catch {
            return false
        }
 
        return true
    }
    
    func editar(appDelegate : AppDelegate) -> Bool{
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Contato")
        
        fetchRequest.predicate = NSPredicate(format: "nome = %@", self.contato.nome ?? "")
        
        do {
            let resultado = try context.fetch(fetchRequest)
            let contatoUpdate = resultado[0] as! NSManagedObject
            
            setContatoValues(contatoBD: contatoUpdate)
            
            try context.save()
        } catch {
           return false
        }
        return true
    }
    
    func setContatoValues(contatoBD : NSManagedObject){
        let celular_completo = buildCelularCompleto()
        let intimidade = buildIntimidade()
        
        contatoBD.setValue(nome.text, forKey:"nome")
        contatoBD.setValue(sobrenome.text, forKey: "sobrenome")
        contatoBD.setValue(celular_completo, forKey: "numero")
        contatoBD.setValue(intimidade, forKey: "intimidade")
    }
    
    func createCustumeMessage(message : String){
        
        let alertAction = UIAlertAction( title : "Ok", style : .cancel) {
            action in (self.navigationController?.popToRootViewController(animated: true));
        }
        
        let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .alert)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func buildCelularCompleto() -> String{
        let enteredCountryCode = String(pais.text!)
        let enteredStateCode = String(ddd.text!)
        let enteredCellPhone = String(celular.text!)
        
        return enteredCountryCode + " " + enteredStateCode + " " + enteredCellPhone
    }
    
    func buildIntimidade() -> Int{
        let enteredIntimacy =  String(intimidade.text!)
        return (enteredIntimacy as NSString).integerValue
    }
}



