//
//  UIViewController + Extension.swift
//  SeSACWeek5
//
//  Created by 김현지 on 7/29/25.
//

import UIKit

extension UIViewController {
    //탈출 클로저 @escaping
    //이미 showAlert의 메서드 생명주기는 끝난 상태
    func showAlert(title: String, message: String, ok: String, okHandler: @escaping () -> Void) {
        print("-----1------")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "저장", style: .default) { _ in
            print("버튼 클릭")
            okHandler()
            print("-----3------")

        }
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancle)
        
        self.present(alert, animated: true)
        print("-----2------")

    }
}
