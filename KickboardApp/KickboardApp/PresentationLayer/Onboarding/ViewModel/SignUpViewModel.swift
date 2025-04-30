//
//  SignUpViewModel.swift
//  KickboardApp
//
//  Created by 권순욱 on 4/30/25.
//

import Foundation

enum SignUpStatus {
    case id, password, nickname
    
    var title: String {
        switch self {
        case .id:
            "아이디를 입력해주세요."
        case .password:
            "비밀번호를 입력해주세요."
        case .nickname:
            "닉네임을 입력해주세요."
        }
    }
    
    var description: String {
        switch self {
        case .id:
            "아이디는 영문 소문자로 시작하는 5~20자\n길이의 영문 소문자, 숫자 조합이어야 합니다."
        case .password:
            "비밀번호는 8~20자 사이로 영문 대/소문자,\n숫자, 특수문자 중 2가지 이상을 조합해야 합니다."
        case .nickname:
            "닉네임은 2~10자 사이로 한글, 영문, 숫자를 사용할 수 있으며,\n특수문자는 사용할 수 없습니다."
        }
    }
}

final class SignUpViewModel {
}
