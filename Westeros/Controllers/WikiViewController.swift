//
//  WikiViewController.swift
//  Westeros
//
//  Created by Javier Finez on 20/09/2018.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    // Mark: - Outles
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    // Mark: - Properties
    var model: House
    
    // Mark: - Initialization
    init(model: House) {
        // 1. Limpio mi M***
        self.model = model
        // 2. Llamo a super
        super.init(nibName: nil, bundle: nil)
        
        // 3. Usas las properties de tu superclase
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta en las notificaciones, osea, me subscribo a aquellos eventos que me interesan
        // En este caso, me quiero enterar de cuando se cambia una casa
        // "Quiero observar los cambios de casa (notification con nombre HouseDidChangeNotificationName)
        // y cuando ocurra, quiero ejecutar el metodo houseDidChange"
        NotificationCenter.default.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil) // object es quien lo manda
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Aqui nos damos de baja en las notificaciones
        // No nos interesa seguir recibiendo las actualizaciones de las casas
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Asignar delegados
        webView.navigationDelegate = self
        
        syncModelWithView()
        
    }
    
    // MARK: Notifications
    @objc func houseDidChange(notification: Notification) {
        // sacar la info y  Extraer la casa
        guard let info = notification.userInfo,
         let house = info[Constants.houseKey] as? House else { return }
    
        // Actualizar el modelo
        self.model = house
        
        // Sincronizar modelo - vista
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        
        title = model.name
        let request: URLRequest = URLRequest(url: model.wikiUrl)
        loadingView.startAnimating()
        webView.load(request)
    }
}

extension WikiViewController: WKNavigationDelegate { // Should, Will, Did
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // detener el spinner
        loadingView.stopAnimating()
        // Ocultarlo
        loadingView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        
        switch type {
        case .linkActivated, .formSubmitted, .formResubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
    
}
