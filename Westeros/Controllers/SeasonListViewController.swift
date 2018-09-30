//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 26/9/18.
//

import UIKit

protocol SeasonListViewControllerDelegate {
    // Should
    // Will
    // Did
    // Convencion: El primer parametro de las funciones del delegate es SIEMPRE el objeto
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

class SeasonListViewController: UITableViewController {

    // Mark: - Properties
    let model: [Season]
    var delegate: SeasonListViewControllerDelegate?
    
    // Mark: - Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Descubir el item (casa) que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Crear una celda (o que nos la den del caché)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda (view) y casa (model)
        cell?.textLabel?.text  = season.name
        
        // Devolver la celda
        return cell!
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la temporada en cuestion
        let theSeason = season(at: indexPath.row)
        
        // SIEMPRE emitir la informacion a traves de los dos metodos: delegates y notifications
        // Avisar/Informar al delegado
        delegate?.seasonListViewController(self, didSelectSeason: theSeason)
        
        // Enviar una notificacion
        let nc = NotificationCenter.default
        let notification = Notification(name: .seasonDidChangeNotification, object: self,
                                        userInfo: [Constants.seasonKey : theSeason])
        nc.post(notification)
        
        // Guardamos la ultima temporada seleccionada
        saveLastSelectedSeason(at: indexPath.row)
    }
    
}

// MARK: - Persistence (UserDefauls) Solo sirve para persistir PEQUENAS cantidades de objetos
// Los objectos tiene que ser sencillos: String, Int, Array, ...
extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        // Aqui vamos a guardar la ultima temporada seleccionada
        let userDefaults = UserDefaults.standard
        
        // Lo insertamos en el diccionario de User Defaults
        userDefaults.set(row, forKey: Constants.lastSeasonKey)
        
        // Guardar
        userDefaults.synchronize() // Por si acaso
    }
    
    func lastSelectedSeason() -> Season {
        // Averiguar cual es la ultima row seleccionada (si la hay)
        let row = UserDefaults.standard.integer(forKey: Constants.lastSeasonKey) // Value 0 es el default
        return season(at: row)
    }
    
    func season(at index: Int) -> Season {
        return model[index]
    }
}

extension SeasonListViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        navigationController?.pushViewController(SeasonDetailViewController(model: season), animated: true)
    }
}
