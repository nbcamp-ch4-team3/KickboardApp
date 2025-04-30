//
//  UserCoreData.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import CoreData

protocol UserCoreDataProtocol {
    func isExistUser(_ id: String) throws -> Bool
    func validatePassword(_ password: String, for id: String) throws -> Bool
}

final class UserCoreData: UserCoreDataProtocol {
    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = CoreDataStorage.shared.persistentContainer.viewContext
    }
    
    // 코어 데이터에 해당 id가 있는지 확인
    func isExistUser(_ id: String) throws -> Bool {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            if !users.isEmpty { return true }
        } catch {
            throw CoreDataError.readError(error)
        }
        
        return false
    }
    
    // 해당 id에 대해 비밀번호가 맞는지 확인
    func validatePassword(_ password: String, for id: String) throws -> Bool {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            
            for user in users {
                if user.password == password {
                    return true
                }
            }
        } catch {
            throw CoreDataError.readError(error)
        }
        
        return false
    }
}
