//
//  RepoPresenter.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

class RepoPresenter: RepoPresenterProtocol {

    weak var view: RepoViewProtocol?
    
    var interactor: RepoInteractorInputProtocol?
    
    var wireFrame: RepoWireframeProtocol?
    
    var fetchingMore: Bool = false
    
    func callRepoItens() {
        interactor?.page += 1
        interactor?.callRepoItens()
    }
    
    func pullToRefreshRepo() {
        interactor?.page = 1
        interactor?.callPullToRefresh()
    }

    func scrollTableView(scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            if fetchingMore {
                fetchingMore = false
                callRepoItens()
            }
        }
    }
}

extension RepoPresenter: RepoInteractorOutputProtocol {
    
    func sucessRepo(itensRepo: [Item]) {
        view?.showItens(itensRepo: itensRepo)
    }
    
    func failRepo() {
        view?.failRepo()
    }
    
}
