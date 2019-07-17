//
//  RepoViewControllerSpec.swift
//  BestSwiftRepoTests
//
//  Created by Thiago M Faria on 17/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import BestSwiftRepo

class RepoViewControllerSpec: QuickSpec {

    class RepoPresenterMock: RepoPresenterProtocol {
        
        var view: RepoViewProtocol?
        
        var interactor: RepoInteractorInputProtocol?
        
        var wireFrame: RepoWireframeProtocol?
        
        func callRepoItens() {
            interactor?.callRepoItens()
        }
        
        func pullToRefreshRepo() {
            interactor?.callPullToRefresh()
        }
        
    }
    
    private var presenter: RepoPresenterMock!
    var sut: RepoViewController!
    var shouldSnapShot = false
    
    override func spec() {
        describe("RepoView") {
            
            beforeEach {
                 let navController = Storyboard.repoStoryboard.instantiateViewController(withIdentifier: "RepoController") as! UINavigationController
                
                self.sut = navController.children.first as? RepoViewController
                self.presenter = RepoPresenterMock()
                self.presenter.view = self.sut

                self.sut.presenter = self.presenter
                _ = self.sut.view
            }
            
            describe("load repositorie data") {
                context("when load mock json") {
                    it("should have 25 repo loaded") {
                        
                        let repo = Utils.loadJson(filename: "repo")
        
                        self.sut.configureTbv(itens: repo?.items ?? [])
                        
                        expect(self.sut.repoTbv.numberOfRows(inSection: 0)).to(equal(25))
                    }
                    
                    it("should record tableview with best repositories") {
                        
                        let repo = Utils.loadJson(filename: "repo")
                        self.sut.configureTbv(itens: repo?.items ?? [])
                        if self.shouldSnapShot {
                            expect(self.sut).to(recordSnapshot(named: "RepoViewController"))
                        } else {
                            expect(self.sut) == snapshot("RepoViewController")
                        }
                    }
                }
            }
        }
    }

}
