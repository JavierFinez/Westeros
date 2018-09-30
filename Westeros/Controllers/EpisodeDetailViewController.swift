//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 29/9/18.
//


import UIKit

class EpisodeDetailViewController: UIViewController {
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    // MARK: - Initialization
    init(model: Episode) {
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
    
    // Fix UITextView initial scroll
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        self.title = self.model.title
        titleLabel.text = self.model.title

    }
}
