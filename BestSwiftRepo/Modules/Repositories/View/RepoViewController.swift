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
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavDesign()
        confHUD()
        confPulltoRefresh()
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
    
    func confPulltoRefresh() {
        
        if #available(iOS 10.0, *) {
            
            repoTbv.refreshControl = refreshControl
            
        } else {
            
            repoTbv.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshTbv(_:)), for: .valueChanged)
    }
    
    func configureTbv(itens: [Item]) {
        
        customElements = []
        
        for item in itens {
            customElements.append(RepoElement.init(item: item))
        }
        
        repoTbv.register(RepoViewCell.self, forCellReuseIdentifier: CustomRepoType.dataCell.rawValue)
        repoTbv.register(LoadViewCell.self, forCellReuseIdentifier: CustomRepoType.loadCell.rawValue)
        
        repoTbv.rowHeight = UITableView.automaticDimension
        repoTbv.estimatedRowHeight = 50
        repoTbv.reloadData()
    }
    
    @objc private func refreshTbv(_ sender: Any) {
        
        presenter?.pullToRefreshRepo()
    }
}

extension RepoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return customElements.count
        } else if section == 1 && presenter!.fetchingMore {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cellModel = customElements[indexPath.row]
            let cellIdentifier = cellModel.type.rawValue
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomRepoElementCell
            
            customCell.configure(withModel: cellModel)
            
            return customCell as! UITableViewCell
        
        } else {
            
            let cellModel = LoadElement.init()
            let cellIdentifier = cellModel.type.rawValue
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomRepoElementCell
            
            customCell.configure(withModel: cellModel)
            
            return customCell as! UITableViewCell
        }
    }
}

extension RepoViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        presenter?.scrollTableView(scrollView: scrollView)
    }
}

extension RepoViewController: RepoViewProtocol {
    
    func showItens(itensRepo: [Item]) {
        presenter?.fetchingMore = true
        self.refreshControl.endRefreshing()
        hud.dismiss()
        configureTbv(itens: itensRepo)
    }
    
    func failRepo() {
        
        let alert = UIAlertController(title: "Alerta", message: "Houve algum erro ao requisitar os dados.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                self.hud.dismiss()
                self.refreshControl.endRefreshing()
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
