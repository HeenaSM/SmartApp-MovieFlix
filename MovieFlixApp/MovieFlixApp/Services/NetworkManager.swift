//
//  NetworkManager.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//

import Foundation
import Alamofire

enum UrlStr: String{
    case posterUrl = "https://image.tmdb.org/t/p/w342"
    case backdropUrl = "https://image.tmdb.org/t/p/original"
}

struct NetworkManager {
    static var shared = NetworkManager()
    
    private var baseUrl = "https://api.themoviedb.org/3/movie"
    private var api_kay = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    func fetchNowPlayingMovie(with endPoint: String, completion: @escaping (MovieData?, Error?) -> ()) {
        let url = "\(baseUrl)/\(endPoint)?api_key=\(api_kay)"
        print(url)
        Alamofire.request(url).responseMovie { (response) in
            if let error = response.error{
                completion(nil,error)
                return
            }
            if let movieData = response.result.value{
                completion(movieData,nil)
                return
            }
        }
    }
    
    func fetchTopRatedMovie(with endPoint: String, completion: @escaping (MovieData?, Error?) -> ()) {
        let url = "\(baseUrl)/\(endPoint)?api_key=\(api_kay)"
        
        Alamofire.request(url).responseMovie { (response) in
            if let error = response.error{
                completion(nil,error)
                return
            }
            if let movieData = response.result.value{
                completion(movieData,nil)
                return
            }
        }
    }
}


class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
