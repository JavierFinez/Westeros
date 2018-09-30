//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 29/9/18.
//

import UIKit

class MemberDetailViewController: UIViewController {
    // MARK: - Properties
    var model: Person
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Person) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        self.title = self.model.name
        nameLabel.text = self.model.name
        houseLabel.text = "Casa \(self.model.house.name)"
        aliasLabel.text = self.model.alias
    }
}
