//
//  DataPersistanceManager.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 29/06/22.
//

import Foundation
import UIKit
import CoreData


class DataPersistanceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistanceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print(DatabaseError.failedToSaveData)
        }
    }
    
    
    func fetchingTitlesFromDataBase(complesion: @escaping (Result<[TitleItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            complesion(.success(titles))
        } catch {
            complesion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    
    func deleteTitleWidth(model: TitleItem, complition: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            complition(.success(()))
        } catch {
            complition(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
}
