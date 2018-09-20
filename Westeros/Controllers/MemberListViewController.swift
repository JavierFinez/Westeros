//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Javier Finez on 20/09/2018.
//

import UIKit

class MemberListViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Mark: - Properties
    let model: [Person]
    
    // Mark: - Initialization
    init(model: [Person]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // FUNDAMENTAL!!! No olvidarse de contar al tableview quienes son sus ayudantes (datasource y delegate)
        tableView.dataSource = self
    }
}

extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "PersonCell"
        
        // Descubrimos cual es la Person que hay que mostrar
        let person = model[indexPath.row]
        
        // Creamos la celda (o nos la dan de cache)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        // Sincronizar modelo-vista (person-cell)
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias

        return cell!
    }
}
