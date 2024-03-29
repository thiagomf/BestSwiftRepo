//
//  RepoProtocols.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

protocol CustomRepoElementModel: class {
    var type: CustomRepoType { get }
}

protocol CustomRepoElementCell: class {
    func configure(withModel: CustomRepoElementModel)
}

//MARK: View -
protocol RepoViewProtocol: class {
    
    var presenter: RepoPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func showItens(itensRepo: [Item])
    func failRepo()
}

//MARK: Wireframe -
protocol RepoWireframeProtocol: class {
    
    static func createRepoScreenModule() -> UINavigationController
}

//MARK: Presenter -
protocol RepoPresenterProtocol: class {
    
    var view: RepoViewProtocol? { get set }
    var interactor: RepoInteractorInputProtocol? { get set }
    var wireFrame: RepoWireframeProtocol? { get set }
    var fetchingMore: Bool { get set }
    
    func callRepoItens()
    func pullToRefreshRepo()
    func scrollTableView(scrollView: UIScrollView)
}

//MARK: Interactor -
protocol RepoInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
    func sucessRepo(itensRepo: [Item])
    func failRepo()
}

protocol RepoInteractorInputProtocol: class {
    
    var presenter: RepoInteractorOutputProtocol?  { get set }
    var remoteDataManager: RepoRemoteDataManagerInputProtocol? { get set }
    var page: Int { get set }
    
    /* Presenter -> Interactor */
    func callRepoItens()
    func callPullToRefresh()
}

protocol RepoRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RepoRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func callAPIItensRepo(page: Int)
    func callAPIPullToRefresh(page: Int)
}

protocol RepoRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func sucessItens(repo: Repositories)
    func sucessPullToRefresh(repo: Repositories)
    func failItens()
}
