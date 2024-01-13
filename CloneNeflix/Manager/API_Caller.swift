//
//  API_Caller.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 12/01/2024.
//

import Foundation

struct Constaints {
    static var API_KEYS = "b9517769c1917cd14ccf773729483dfc"
    static var base_Address = "https://api.themoviedb.org/3"
    
}

enum APIError: Error{
    case failedTogetData
}
class API_Caller {
    static var shared = API_Caller()
    
    func getTrendingMovies(completion :@escaping (Result<[Title], Error>) -> Void ){
        guard let url = URL(string: "\(Constaints.base_Address)/trending/movie/day?api_key=\(Constaints.API_KEYS)") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data,_,error) in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTv(completion :@escaping (Result<[Title], Error>) -> Void ){
        guard let url = URL(string: "\(Constaints.base_Address)/trending/tv/day?api_key=\(Constaints.API_KEYS)") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data,_,error) in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    func getUpcoming(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constaints.base_Address)/movie/upcoming?api_key=\(Constaints.API_KEYS)&language=en-US&page=1") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data,_,error) in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
            
        }
        task.resume()
    }
    
    func getPopular(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constaints.base_Address)/movie/popular?api_key=\(Constaints.API_KEYS)&language=en-US&page=1") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data,_,error) in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
            
        }
        task.resume()
    }
    
   
    
    func getToprate(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constaints.base_Address)/movie/top_rated?api_key=\(Constaints.API_KEYS)&language=en-US&page=1") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url){(data,_,error) in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch {
                completion(.failure(APIError.failedTogetData))
            }
            
        }
        task.resume()
    }
    
    
}
