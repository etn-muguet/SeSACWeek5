//
//  DetailViewController.swift
//  SeSACWeek5
//
//  Created by 김현지 on 7/31/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    let textField = UITextField()
    
    var content: ((String) -> Void)? //이게 머지 함수?변수?함수의 이름을 정한거?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail view", #function)
        
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        textField.placeholder = "입력하세요"
//        textField.text = content
        
        view.backgroundColor = .lightGray
        navigationItem.title = "디테일 화면"
        
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        textField.becomeFirstResponder()//화면전환할때 동시에 키보드가 뜸
        

    }
    @objc func closeButtonClicked() {
        print(#function)
        //dismiss가 되지않고 키보드 내려가게
        textField.resignFirstResponder()//리스폰더 체인
//        content?(textField.text!)
//        dismiss(animated: true)

    }



}
