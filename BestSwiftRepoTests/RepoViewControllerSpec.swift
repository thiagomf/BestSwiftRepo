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
        
        var callRepo = false
        
        var callPull = false
        
        func callRepoItens() {
            callRepo = true
        }
        
        func pullToRefreshRepo() {
            callPull = true
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
                
                let repo = Utils.loadJson(filename: "repo")
                
                self.sut.configureTbv(itens: repo?.items ?? [])
            }
            
            describe("load repositorie data") {
                context("when load mock json") {
                    it("should have 25 repo loaded") {
                        
                        expect(self.sut.repoTbv.numberOfRows(inSection: 0)).to(equal(25))
                    }
                    
                    it("should record tableview with best repositories") {
                        
                        if self.shouldSnapShot {
                            expect(self.sut).to(recordSnapshot(named: "RepoViewController"))
                        } else {
                            expect(self.sut) == snapshot("RepoViewController")
                        }
                    }
                    
                    it("should protocol presenter mock is true") {
                        
                        self.presenter.callRepoItens()
                        
                        expect(self.presenter.callRepo).to(equal(true))
                        
                        self.presenter.pullToRefreshRepo()
                        
                        expect(self.presenter.callPull).to(equal(true))
                    }
                }
                
                context("RepoViewCell") {
                    var cell: RepoViewCell!
                    
                    beforeEach {
                        
                        let repo = Utils.loadJson(filename: "repo")
                        
                        self.sut.showItens(itensRepo: repo?.items ?? [])
                        
                        cell = self.sut.tableView(self.sut.repoTbv, cellForRowAt: IndexPath(row: 0, section: 0)) as? RepoViewCell
                        
                    }
                    
                    it("should show repo name stars and author name") {
                        
                        expect(cell.repoName.text).to(equal("awesome-ios"))
                        expect(cell.authorName.text).to(equal("vsouza"))
                        expect(cell.countStars.text).to(equal("32324"))
                    }
                    
                    it("should record RepoViewCell row 0") {
                        
                        if self.shouldSnapShot {
                            expect(cell).to(recordSnapshot(named: "RepoViewCell"))
                        } else {
                            expect(cell) == snapshot("RepoViewCell")
                        }
                    }
                }
                
                context("LoadViewCell") {
                    var cell: LoadViewCell!
                    
                    beforeEach {
                        
                        let repo = Utils.loadJson(filename: "repo")
                        
                        self.sut.showItens(itensRepo: repo?.items ?? [])
                        
                        cell = self.sut.tableView(self.sut.repoTbv, cellForRowAt: IndexPath(row: 0, section: 1)) as? LoadViewCell
                        
                    }
                    
                    it("should show start activity animation") {
                        
                        expect(cell.loadProgress.isAnimating).to(equal(true))
                    }
                    
                    it("should record LoadViewCell row 0") {
                        
                        if self.shouldSnapShot {
                            expect(cell).to(recordSnapshot(named: "LoadViewCell"))
                        } else {
                            expect(cell) == snapshot("LoadViewCell")
                        }
                    }
                }
            }
        }
    }
}
