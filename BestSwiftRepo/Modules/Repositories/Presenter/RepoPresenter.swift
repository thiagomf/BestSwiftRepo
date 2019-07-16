//
//  RepoPresenter.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

class RepoPresenter: RepoPresenterProtocol {
    var view: RepoViewProtocol?
    
    var interactor: RepoInteractorInputProtocol?
    
    var wireFrame: RepoWireframeProtocol?
    
    func callRepoItens() {
        
    }

}

extension RepoPresenter: RepoInteractorOutputProtocol {
    
    func sucessRepo(itensRepo: [Item]) {
        
    }
    
    func failRepo() {
        
    }
    
    
}
