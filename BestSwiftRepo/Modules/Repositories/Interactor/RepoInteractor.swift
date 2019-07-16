//
//  RepoInteractor.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

class RepoInteractor: RepoInteractorInputProtocol {
    
    var presenter: RepoInteractorOutputProtocol?
    
    var remoteDataManager: RepoRemoteDataManagerInputProtocol?
    
    var page: Int = 0
    
    var items: [Item] = []
    
    func callRepoItens() {
        remoteDataManager?.callAPIItensRepo(page: page)
    }
    
}

extension RepoInteractor: RepoRemoteDataManagerOutputProtocol {
    func sucessItens(repo: Repositories) {
        items.append(contentsOf: repo.items)
        presenter?.sucessRepo(itensRepo: items)
    }
    
    func failItens() {
        presenter?.failRepo()
    }
    
}
