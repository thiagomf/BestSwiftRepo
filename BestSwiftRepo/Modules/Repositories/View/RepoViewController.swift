//
//  ViewController.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit
import JGProgressHUD

class RepoViewController: UIViewController {

    @IBOutlet weak var repoTbv: UITableView!
    
    var presenter: RepoPresenterProtocol?
    
    var customElements: [CustomRepoElementModel]! = []
    
     let hud = JGProgressHUD(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavDesign()
        confHUD()
        hud.show(in: self.view)
        presenter?.callRepoItens()
    }
    
    func setupNavDesign() {
        
        self.navigationController?.navigationBar.topItem?.title = "Best Repositories"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)]
    }
    
    func confHUD() {
        
        hud.textLabel.text = "Carregando"
    }
    
    func configureTbv(itens: [Item]) {
        
        for item in itens {
            customElements.append(RepoElement.init(item: item))
        }
        
        repoTbv.register(RepoViewCell.self, forCellReuseIdentifier: CustomRepoType.dataCell.rawValue)
        
        repoTbv.rowHeight = UITableView.automaticDimension
        repoTbv.estimatedRowHeight = 50
        repoTbv.reloadData()
    }
}

extension RepoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = customElements[indexPath.row]
        let cellIdentifier = cellModel.type.rawValue
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomRepoElementCell
        
        customCell.configure(withModel: cellModel)
        
        return customCell as! UITableViewCell
    }
}

extension RepoViewController: RepoViewProtocol {
    
    func showItens(itensRepo: [Item]) {
        hud.dismiss()
        configureTbv(itens: itensRepo)
    }
    
    func failRepo() {
        
        let alert = UIAlertController(title: "Alerta", message: "Houve algum erro ao requisitar os dados.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("unknow")
            }
        }))
    
        self.present(alert, animated: true, completion: nil)
    }
    
}
