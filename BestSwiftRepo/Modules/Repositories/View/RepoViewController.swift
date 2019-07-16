//
//  ViewController.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    @IBOutlet weak var repoTbv: UITableView!
    
    var presenter: RepoPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("teste")
    }
}

extension RepoViewController: RepoViewProtocol {
    
    func sucessRepo(itensRepo: [Item]) {
        
    }
    
    func failRepo() {
        
    }
    
}
