//
//  ViewController.swift
//  practica5_SQLite
//
//  Created by Isc. Torres on 11/23/19.
//  Copyright © 2019 isctorres. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var guardarModelo: UITextField!
    @IBOutlet weak var precioModelo: UITextField!
    @IBOutlet weak var buscarModelo: UITextField!
    
    let objetoFileHelper = FileHelper()
    var miDB: FMDatabase? = nil
    var alerta: UIAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miDB = FMDatabase(path: objetoFileHelper.pathArchivoEnCarpetaDocumentos("Motos"))
    }

    @IBAction func guarda(_ sender: UIButton) {
        if guardarModelo.hasText && precioModelo.hasText {
            print("Datos llenados correctamente")
            almacena(guardarModelo.text!,precio: Int(precioModelo.text!)!)
        }else{
            
            print("Existe campos vacios")
        }
    }
    
    @IBAction func buscar(_ sender: UIButton) {
        if buscarModelo.hasText {
            print("Datos llenados correctamente")
            encuentra(buscarModelo.text!)
        }else{
            print("Debes proporcionar un valor a buscar")
        }
    }
    
    func almacena(_ modelo: String, precio: Int){
        if( miDB!.open() ){
            let inserta = miDB?.executeUpdate("INSERT INTO Motos(modelo,precio) VALUES(?,?)", withArgumentsIn: [modelo,precio])
            miDB!.close()
            if inserta! {
                alerta = UIAlertController(title: "SQLite", message: "Registro Almacenado \(modelo) \(precio)", preferredStyle: .alert)
                alerta!.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
                present(alerta!, animated: true, completion: nil)
            }
            else{
                print("No se pudo guardar")
            }
                
        }else{
            print("La BD no esta disponible")
        }
    }
    
    func encuentra(_ modelos: String){
        var precio: Int32?
        if( miDB!.open() ){
            let querySQL = "SELECT * FROM Motos WHERE modelo = '"+modelos+"'";
            let resultados:FMResultSet? = try! miDB!.executeQuery(querySQL, withParameterDictionary: nil)
            while resultados!.next() == true {
                print(modelos, precio)
                precio = resultados!.int(forColumn: "precio")
                let modelo = resultados?.string(forColumn: "modelo")
            }
            miDB!.close()
            
            alerta = UIAlertController(title: "SQLite", message: "El modelo es: \(modelos) y el precio es: \(precio)", preferredStyle: .alert)
            alerta!.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
            present(alerta!, animated: true, completion: nil)
                    
        }
        else{
            print("La BD no esta disponible")
        }
    }
}

