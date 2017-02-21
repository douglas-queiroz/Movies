//
//  MovieRequester.swift
//  MoviesApp
//
//  Created by Douglas Queiroz on 15/02/17.
//  Copyright © 2017 Douglas Queiroz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MovieRequester {
    func getMovies(with title: String, completion: @escaping ((_ movies: [Movie], _ errorMsg: String?)->Void)) {
        
        let param: [String: Any] = ["s": title]
        
        request(URL_API, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil)
            .responseArray(queue: nil, keyPath: "Search", context: nil) { (response: DataResponse<[Movie]>) in
            
                if let result = response.result.value {
                    completion(result, nil)
                }else{
                    completion([Movie](), "Ocorreu um problema ao consultar o servidor")
                }
        }
    }
}
