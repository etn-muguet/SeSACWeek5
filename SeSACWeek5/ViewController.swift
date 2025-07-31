//
//  ViewController.swift
//  SeSACWeek5
//
//  Created by 김현지 on 7/29/25.
//

import UIKit
import SnapKit

//동기와 비동기
class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let button = UIButton()
    let s = UISwitch()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
//        serialSync()
//        serialAsync()
//        concurrentAsync()
//        concurrentSync()
//        globalQualityOfService()
        
        dispatchGroupA()
        
    }
    func dispatchGroupA() {
        //동기메서드에 적합
        let group = DispatchGroup()
        
        print("AAAAA")
        DispatchQueue.global().async(group: group) {
            for i in 1...50 {
                print(i)
            }
        }
        print("BBBBB")

        DispatchQueue.global().async(group: group) {
            for i in 51...100 {
                print(i)
            }
        }
        print("CCCCC")

        DispatchQueue.global().async(group: group) {
            for i in 101...150 {
                print(i)
            }
        }
        print("DDDDD")

        DispatchQueue.global().async(group: group) {
            for i in 151...200 {
                print(i)
            }
        }
        print("EEEEE")
        
        group.notify(queue: .main) { //제일 마지막에 실행됨 
            print("끝났다")
        }

    
        
    }
    func dispatchGroupB() {
        
        for i in 1...50 {
            
        }
    }
    
    
    //여러 알바생이 일을 나눠 하니까 작업은 더 빨리 끝날 수 있지만
    //어떤 일이 먼저 끝날지 알기는 어려워, 마지막을 알기는 어려워
    //마지막이 언제 끝날지 알기 위해서는 어떻게 해야할까? >>얼럿 등등 활용하기 위해
    //dispatchGroup로 해결
    //여러 알바생들을 돌려서 작업을 더 빠르게 하고 싶어, 근데 조금 더 빠르게 끝나는 알바생을 만들고 싶어?
    //응답이 화면에 먼저 보이는 것들 위주로 빠르게 끝났으면 할 때 qos:퀄리티 오브 서비스 >> 알바생 속도 조절
    func globalQualityOfService() {
        
        print("start", terminator: " ")
        
//        DispatchQueue.global(qos: .background).async { //좀 천천히ㅣ
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
//        DispatchQueue.global().async {
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
//        DispatchQueue.global(qos: .userInteractive).async {//먼저 끝났으면 좋겠어
//            for i in 201...300 {
//                print(i, terminator: " ")
//            }
//        }
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        for i in 101...200 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        for i in 201...300 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        print("end")
    }
    // 동기 + 동시
    //여러 알바생들한테 맡긴 일이 끝날 때까지 기다렸다가 내 할일 해야지
    //결과가 동기 + 직렬과 다르지 않음
    //실질적으로 메인쓰레드가(닭벼슬) 수행하게 되는 구조
    func concurrentSync() {
        
        print("start", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("end")
    }
    // 비동기 + 동시
    //일을 다른 알바생에게 보내놓고, 다른 알바생 일이 안끝나더라도 내 할 일 수행(비동기) async
    //매니저가 담당하는 일들을 여러 알바생한테 골고루 분배(동시) global()
    func concurrentAsync() {
        
        print("start", terminator: " ")
        
        DispatchQueue.global().async {
            for i in 51...300 {
                print(i, terminator: " ")
         
            }
        }
        for i in 1...50 {
            print(i, terminator: " ")
        }
        print("end")
    }
    //비동기 + 직렬
    //일을 다른 알바생에게 보내놓고, 다른 알바생 일이 안끝나더라도 내 할 일 수행(비동기)
    //다른 알바생한테 골고루 주지 않고 매니저(큐)가 갖고 있는 일을 한 알바생한테 몰아주기(직렬)
    func serialAsync() {
        
        print("start", terminator: " ")
     
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("end")
    }
    
    
    //동기+직렬
    func serialSync() {//일 4개
        
        print("start", terminator: " ")
        //교착상태. 데드락. 무한??상태
        //DispatchQueue.main.sync
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        print("end") // end가 찍히기 위해 앞에 3개를 다 실행해야 함
    }
    
    func configureView() {
        navigationItem.title = "네비게이션 타이틀"
        view.backgroundColor = .yellow
        
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(s)
        
        button.setTitle("클릭하기", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(imageView.snp.horizontalEdges)
            make.top.equalTo(imageView.snp.top)
            make.height.equalTo(44)
        }
        s.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        imageView.backgroundColor = .red
        button.backgroundColor = .systemMint

    }
    //알바생 여러명 두면 해결될 수 있음
    @objc func buttonClicked() {
        print(#function)
        
        //킹피셔 없이 웹주소 이미지 로드
        let url = URL(string: "https://apod.nasa.gov/apod/image/2507/Helix_GC_2332.jpg")!
        print("===1====")
        
        DispatchQueue.global().async {
            let data =  try! Data(contentsOf: url)
            print("===2====")
            
            DispatchQueue.main.async {//글로벌 블럭 안에 있어서 main=메인쓰레드이면서 한번에 일 보낸다?
                self.imageView.image = UIImage(data: data)

            }
        }
        print("===3====")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        showAlert(title: "테스트", message: "얼럿이 떴습니다", ok: "배경바꾸기") {
//            print("버튼 클릭")
//            self.view.backgroundColor = .yellow
//        }

    }

}

