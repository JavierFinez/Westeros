//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Javier Finez de Dios on 29/9/18.
//

import UIKit

class EpisodeListViewController: UITableViewController {
    // MARK: - Properties
    var model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode]) {
        self.model = model
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Episodios"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(seasonDidChange), name: .seasonDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func seasonDidChange(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let season: Season = info[Constants.seasonKey] as? Season else { return }
        model = season.sortedEpisodes
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episodeInstance = episode(at: indexPath.row)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Constants.episodeCell)
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Constants.episodeCell)
        }
        
        cell?.textLabel?.text = episodeInstance.title
        cell?.detailTextLabel?.text = episodeInstance.stringDate
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episodeObj = episode(at: indexPath.row)
        navigationController?.pushViewController(EpisodeDetailViewController(model: episodeObj), animated: true)
    }
}

extension EpisodeListViewController {
    func episode(at row: Int) -> Episode {
        return model[row]
    }
}
