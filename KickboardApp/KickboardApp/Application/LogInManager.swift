//
//  LogInManager.swift
//  KickboardApp
//
//  Created by 권순욱 on 5/1/25.
//

import Foundation

final class LogInManager {
    static let shared = LogInManager()
    
    var isLoggedIn = false
    
    private init() {}
    
    // 로그인 정보 로드
    func loadLogInInfo() {
        let logInInfo = UserDefaults.standard.string(forKey: "id")
        if let logInInfo {
            isLoggedIn = true
            print("logged in: \(logInInfo)")
        }
    }
    
    // 로그인 성공 시 호출
    func saveLogInInfo(_ id: String) {
        UserDefaults.standard.set(id, forKey: "id")
        isLoggedIn = true
    }
    
    // 로그아웃 시 호출
    func deleteLogInInfo() {
        UserDefaults.standard.removeObject(forKey: "id")
        isLoggedIn = false
    }
}
