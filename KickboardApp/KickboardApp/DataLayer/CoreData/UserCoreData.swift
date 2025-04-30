//  UserCoreData.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/29/25.
//

import CoreData

protocol UserCoreDataProtocol {
    func findUser() throws -> UserEntity?
    func isExistUser(_ id: String) throws -> Bool
    func validatePassword(_ password: String, for id: String) throws -> Bool
}

final class UserCoreData: UserCoreDataProtocol {

    private let viewContext: NSManagedObjectContext

    init() {
        self.viewContext = CoreDataStorage.shared.persistentContainer.viewContext
    }

    func findUser() throws -> UserEntity? {
        guard let userId = UserDefaults.standard.string(forKey: "id") else {
            throw UserDefaultsError.invalidKey("id")
        }

        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userId)

        do {
            return try viewContext.fetch(fetchRequest).first
        } catch {
            throw CoreDataError.readError(error)
        }
    }

  // 코어 데이터에 해당 id가 있는지 확인
    func isExistUser(_ id: String) throws -> Bool {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            let users = try viewContext.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            throw CoreDataError.readError(error)
        }
    }

    // 해당 id에 대해 비밀번호가 맞는지 확인
    func validatePassword(_ password: String, for id: String) throws -> Bool {
        let fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            let users = try viewContext.fetch(fetchRequest)

            guard let user = users.first else {
                throw CoreDataError.entityNotFound("validatePassword - nil Data")
            }
            
            return user.password == password
        } catch {
            throw CoreDataError.readError(error)
        }
    }
}

extension UserCoreData {
    private func saveMockData() throws {
        let userEntity = UserEntity(context: viewContext)
        userEntity.id = "이수현"
        userEntity.nickname = "이수현 닉네임"
        userEntity.password = "이수현 패스워드"
        do {
            try viewContext.save()
        } catch {
            throw CoreDataError.saveError(error)
        }
    }
}
