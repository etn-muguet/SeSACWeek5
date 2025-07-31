//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import Alamofire

struct Photo : Decodable {
    let id: String
    let author: String
    let download_url: String
}

class PhotoViewController: UIViewController {
    
    var firstList: [Photo] = []
    var secondList: [Photo] = []

    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        return tableView
    }()
    
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        return tableView
    }()
     
    let button = {
       let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.backgroundColor = .brown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()

        let group = DispatchGroup() // enter로 관리
        
        group.enter() //+1 기록
        self.call(url: "https://picsum.photos/v2/list?page=3") { value in
            self.firstList.append(contentsOf: value)
            print("11111")
            group.leave() //-1 기록
        }
        
        group.enter() //+1 기록
        self.call(url: "https://picsum.photos/v2/list?page=1") { value in
            self.secondList.append(contentsOf: value)
            print("22222")
            group.leave()//-1

        }
        //기록 0이 되는 순간 notify가 호출됨
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.authorTableView.reloadData()
            print("33333")
        
        }
    }
    
    
    func call(url:String, completionHandler: @escaping ([Photo]) -> Void) {
        AF.request(url).responseDecodable(of: [Photo].self) { response in
            switch response.result {
            case .success(let value):
                
                completionHandler(value)
                
            case .failure(let erorr):
                print("실패")
            }
        }
    }
    
    func callRequestAuthor() {
        let url = "https://picsum.photos/v2/list?page=3"
        AF.request(url, method: .get)
//            .responseString { response in
//            print(response)
//            }
            .responseDecodable(of: [Photo].self) { response in
                dump(response)
                switch response.result {
                case .success(let value):
                    
                    self.secondList.append(contentsOf: value)
                    self.authorTableView.reloadData()
                    
                    
                case .failure(let error):
                    print("오류발견")
                }
                
            }
    }
    func callRequest() {
        let url = "https://picsum.photos/v2/list?page=1"
        AF.request(url, method: .get)
//            .responseString { response in
//            print(response)
//            }
            .responseDecodable(of: [Photo].self) { response in
                dump(response)
                switch response.result {
                case .success(let value):
                    
                    self.firstList.append(contentsOf: value)
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("오류발견")
                }
                
            }
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == authorTableView {
            return secondList.count
        } else {
            return firstList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == authorTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as! AuthorTableViewCell
            
            let row = secondList[indexPath.row]//여기서 로우를 안에 넣는건 리스트가 다르니까 나는 같은 리스트를 사용했느네 왜 안됮
            cell.authorLabel.text = row.author
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            
            
            let row = firstList[indexPath.row]
            
            cell.titleLabel.text = row.author
            
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, tableView)
        
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
        

    }
    
}

extension PhotoViewController {
    
    func configureHierarchy() {
        view.addSubview(authorTableView)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func configureLayout() {
         
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.top.equalTo(button.snp.bottom)
        }
        
        authorTableView.snp.makeConstraints { make in
            make.leading.equalTo(tableView.snp.trailing)
            make.verticalEdges.equalTo(tableView)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "통신 테스트"
        view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    @objc func buttonClicked() {
        let vc = DetailViewController()
        
        vc.content = { response in //역 값 전달
//            let a = hello(name:) //얘량 같은거? 근데 위에는 함수이름없고 매개변수만 안에 써준거?
//            a("jack")//이 때 실행됨 >>> a는 함수가 된거임? content?(textField.text!)
            self.button.setTitle(response, for: .normal)
        }
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)

//        navigationController?.pushViewController(vc, animated: true)
    }
    
}
