//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 29/9/18.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Outlets
    @IBOutlet weak var SeasonNameLabel: UILabel!
    @IBOutlet weak var SeasonreleaseDateLabel: UILabel!
    
    // MARK: - Initialization
    init(model: Season) {
        // Primero, limpio mi propio desorden (a.k.a, le doy valor a mis propias propiedades)
        self.model = model
        
        // Despues, llamamos a super
        super.init(nibName: nil, bundle: nil)
    }
    
    // Chapuza de los de Cupertino relacionada con los nil
    // Este init es el que utilizan los Storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        // Sincronizar modelo y vista
        syncModelWithView()
    }
    
    // MARK: - Sync
    func syncModelWithView() {
        SeasonNameLabel.text = " \(model.name)"
        SeasonreleaseDateLabel.text = "\(model.releaseDate)"
        title = model.name
    }
    
    func setupUI() {
        // Crear los botones
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        // Anadir los botones
        navigationItem.rightBarButtonItems = [episodesButton]
    }
    
    @objc func displayEpisodes() {
        // Crear el VC destino
        let episodeViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Navegar a el, push
        navigationController?.pushViewController(episodeViewController, animated: true)
    }
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
        
    }

}
