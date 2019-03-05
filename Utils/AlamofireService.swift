//
//  AlamofireService.swift
//  MoviesSwift
//
//  Created by João Gabriel  on 04/03/2019.
//  Copyright © 2019 fontana. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireService {
    static let moviesURL = "https://desafio-mobile.nyc3.digitaloceanspaces.com/movies"
    static func getMovies(completion: @escaping([Movie]) -> ()) {
        Alamofire.request(moviesURL).responseJSON { (response) in
            guard let responseData = response.data else {
                completion([])
                return
            }
            do {
                if let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String : Any]] {
                    var moviesArray: [Movie] = []
                    for movieDict in dict {
                        if let movie = Movie(movieDictionary: movieDict) {
                            moviesArray.append(movie)
                            movie.downloadImage()
                        }
                    }
                    completion(moviesArray)
                } else {
                    completion([])
                }
            } catch {
                completion([])
            }
        }
    }
    
    static func getMovieWithDetails(movieId: Int, completion: @escaping(MovieWithDetails?) -> ()) {
        var movieStringId: String = ""
        movieStringId += "/"
        movieStringId += movieId.description
        let movieWithDetailsURL = "\(moviesURL)\(movieStringId)"
        Alamofire.request(movieWithDetailsURL).responseJSON { (response) in
            guard let responseData = response.data else {
                completion(nil)
                return
            }
            do {
                if let dict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any] {
                    if let movieWithDetails = MovieWithDetails.init(movieWithDetailsDictionary: dict) {
                        completion(movieWithDetails)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }
    }
    
    
    static func getImage(stringURL: String, completion: @escaping (UIImage?) -> ()) {
        Alamofire.request(stringURL).responseData { (response) in
            if let data = response.data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
