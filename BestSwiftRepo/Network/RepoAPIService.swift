//
//  RepoAPIService.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit
import Alamofire

class RepoAPIService: NSObject, RepoRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: RepoRemoteDataManagerOutputProtocol?
    
    func callAPIItensRepo(page: Int) {
        self.getRepositories(page: page, completion: { repo in
            if let repositor = repo {
                self.remoteRequestHandler?.sucessItens(repo: repositor)
            } else {
                self.remoteRequestHandler?.failItens()
            }
        })
    }
    
    func getRepositories(page: Int,
                                completion: @escaping (Repositories?) -> Void ) {
        
        guard let url = URL(string: "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc&page=\(page)&per_page=25") else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get).validate()
                          .responseJSON { response in
                            
                    switch response.result {
                    case .success:
                        if let jsonData = response.data {
                            let jsonDecoder = JSONDecoder()
                            do {
                                let repo = try jsonDecoder.decode(Repositories.self, from: jsonData)
                                completion(repo)
                            } catch let error{
                                print("Erro: \(error.localizedDescription)")
                                completion(nil)
                                return
                            }
                        }
                    case .failure(let error):
                        print("Erro: \(error.localizedDescription)")
                        completion(nil)
                        return
                    }
        }
    }
}
