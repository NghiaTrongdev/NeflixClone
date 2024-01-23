//
//  DataPersistenceManager.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 22/01/2024.
//

import Foundation
import CoreData
import UIKit

class DataPersistenceManager{
    
    enum DatabasError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static var shared = DataPersistenceManager()
    
    func DownloadTitleWith(model : Title, completion: (Result<Void , Error>) -> Void ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.realease_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabasError.failedToSaveData))
        }
        
    }
    func fetchingfromDatabase(completion : @escaping (Result<[TitleItem] , Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))

        }catch{
            completion(.failure(DatabasError.failedToFetchData))
        }
    }
    func DeleteTitleItemFromDatabase( model :TitleItem, complition : @escaping (Result<Void , Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        do {
            try context.save()
            complition(.success(()))
        }catch{
            complition(.failure(DatabasError.failedToDeleteData))
        }
    }
}
