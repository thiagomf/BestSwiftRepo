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
    
    
}

//MARK: Wireframe -
protocol RepoWireframeProtocol: class {
    
    static func createRepoScreenModule() -> RepoViewController
    
    // PRESENTER -> WIREFRAME
}

//MARK: Presenter -
protocol RepoPresenterProtocol: class {
    
    var view: RepoViewProtocol? { get set }
    var interactor: RepoInteractorInputProtocol? { get set }
    var wireFrame: RepoWireframeProtocol? { get set }

}

//MARK: Interactor -
protocol RepoInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */

}

protocol RepoInteractorInputProtocol: class {
    
    var presenter: RepoInteractorOutputProtocol?  { get set }
    var remoteDataManager: RepoRemoteDataManagerInputProtocol? { get set }
    
    /* Presenter -> Interactor */

}

protocol RepoRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RepoRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER

}

protocol RepoRemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    
}
