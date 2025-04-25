//
//  ViewController.swift
//  KickboardApp
//
//  Created by 최안용 on 4/25/25.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    private let testLabel = UILabel().then {
        $0.text = "pretendardBlack 테스트입니다."
        $0.font = .font(.pretendardBlack, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel2 = UILabel().then {
        $0.text = "pretendardBold 테스트입니다."
        $0.font = .font(.pretendardBold, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel3 = UILabel().then {
        $0.text = "pretendardSemiBold 테스트입니다."
        $0.font = .font(.pretendardSemiBold, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel4 = UILabel().then {
        $0.text = "pretendardExtraBold 테스트입니다."
        $0.font = .font(.pretendardExtraBold, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel5 = UILabel().then {
        $0.text = "pretendardMedium 테스트입니다."
        $0.font = .font(.pretendardMedium, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel6 = UILabel().then {
        $0.text = "pretendardRegular 테스트입니다."
        $0.font = .font(.pretendardRegular, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel7 = UILabel().then {
        $0.text = "pretendardLight 테스트입니다."
        $0.font = .font(.pretendardLight, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel8 = UILabel().then {
        $0.text = "pretendardExtraLight 테스트입니다."
        $0.font = .font(.pretendardExtraLight, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel9 = UILabel().then {
        $0.text = "pretendardThin 테스트입니다."
        $0.font = .font(.pretendardThin, ofSize: 18)
        $0.textAlignment = .center
    }
    private let textField = UITextField().then {
        $0.placeholder = "TextField 테스트입니다."
        $0.font = .font(.pretendardSemiBold, ofSize: 18)
        $0.textAlignment = .center
    }
    
    private let stack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        stack.addArrangedSubviews(testLabel, testLabel2, testLabel3, testLabel4, testLabel5, testLabel6, testLabel7, testLabel8, testLabel9, textField)
        view.addSubViews(stack)
    
        stack.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }


}

