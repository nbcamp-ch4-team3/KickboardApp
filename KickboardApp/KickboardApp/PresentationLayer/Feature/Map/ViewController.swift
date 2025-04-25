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
        $0.text = "pgmarketSansBold 테스트입니다."
        $0.font = .font(.gmarketSansBold, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel2 = UILabel().then {
        $0.text = "gmarketSanfsMedium 테스트입니다."
        $0.font = .font(.gmarketSansMedium, ofSize: 18)
        $0.textAlignment = .center
    }
    private let testLabel3 = UILabel().then {
        $0.text = "gpjqmarketSansLight 테스트입니다."
        $0.font = .font(.gmarketSansLight, ofSize: 18)
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubViews(testLabel, testLabel2, testLabel3)
        testLabel.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(200)
        }
        testLabel2.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(testLabel.snp.bottom).offset(20)
        }
        testLabel3.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(testLabel2.snp.bottom).offset(20)
        }
    }


}

