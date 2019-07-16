//
//  RepoRouter.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

class RepoRouter: RepoWireframeProtocol {
    
    static func createRepoScreenModule() -> UINavigationController {
        
        let navController = Storyboard.repoStoryboard.instantiateViewController(withIdentifier: "RepoController") as! UINavigationController
        
        if let view = navController.children.first as? RepoViewController {
            
            let presenter: RepoPresenterProtocol & RepoInteractorOutputProtocol = RepoPresenter()
            let interactor: RepoInteractorInputProtocol & RepoRemoteDataManagerOutputProtocol = RepoInteractor()
            let remoteDataManager: RepoRemoteDataManagerInputProtocol = RepoAPIService()
            let wireFrame: RepoWireframeProtocol = RepoRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
        }
        
        return navController
    }
    

}
