//
//  SettingViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SettingViewController: UIViewController {
    
    let cellItem = SettingItemlList()
    
    var tamagoList = TamagotchiList().tamagotchi
    
    var tamagotchi = Tamagotchi(id: 0, type: "", name: "", rice: 0, water: 0)
    
    var notificationUserName: String?
    
    var notificationState: NotificatioinCenterState = .none
    
    @IBOutlet var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        setNavBar()
        
        self.view.backgroundColor = Design.backgroundColor
        settingTableView.backgroundColor = Design.backgroundColor
        
        settingTableView.rowHeight = 70
        
        let nib = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(userNameNotification), name: NSNotification.Name("UserName"), object: nil)
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let index = [IndexPath(row: 0, section: 0), IndexPath(row: 0, section: 1)]
//
//        settingTableView.reloadRows(at: index, with: .none)
//
//    }
    
    @objc func userNameNotification(notification: NSNotification) {
        //여기서 전달받은 값을 프로퍼티에 할당하고, 테이블뷰 셀을 리로드하면 됨
        if let userName = notification.userInfo?["userName"] as? String {
            notificationState = .post
            notificationUserName = userName
            let index = [IndexPath(row: 0, section: 0), IndexPath(row: 0, section: 1)]
            
            settingTableView.reloadRows(at: index, with: .none)
        }
    }
    
    func setNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(popNavController))
        navigationItem.leftBarButtonItem?.tintColor = Design.fontAndBorderColor
        
        navigationItem.title = "설정"
    }
    
    @objc func popNavController() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            transition(vc: ChangeUserNameViewController.self, storyBoard: StoryboardName.changeUserName.rawValue, transitionStyle: .push)
            
        } else if indexPath.row == 1 {
            
            let sb = UIStoryboard(name: StoryboardName.selectTamagotchi.rawValue, bundle: nil)
            
            guard let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiViewController.identifier) as? SelectTamagotchiViewController else { return }
            
            vc.mode = .change
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 2 {
            
            //MARK: - 익스텐션의 인스턴스 메서드로 기능을 추가해서 코드를 간략하게 해보자
            let alert = UIAlertController(title: "데이터 초기화", message: #""확인"버튼을 누르면 데이터가 초기화 됩니다."#, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            let okay = UIAlertAction(title: "확인", style: .default) { okay in
                
                UserDefaults.standard.set(false, forKey: "launched")
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: StoryboardName.selectTamagotchi.rawValue , bundle: nil)
                
                guard let vc = sb.instantiateViewController(withIdentifier: SelectTamagotchiViewController.identifier) as? SelectTamagotchiViewController else { return }
                
                let nav = UINavigationController(rootViewController: vc)
                
                for tamago in self.tamagoList {
                    Methods.saveTamagotchiStruct(tamagotchi: tamago)
                }
                
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            alert.addAction(cancel)
            alert.addAction(okay)
            
            present(alert, animated: true)
        }
        
    }
    
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellItem.list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: - 익스텐션에서 테이블뷰셀, 컬렉션뷰 셀 아이덴티파이어 만들기
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.setUIContents(item: cellItem.list[indexPath.row])
        
        if indexPath.row == 0 {
            
            switch notificationState {
            case .post:
                cell.cellSubTitleLabel.text = notificationUserName
            case .none:
                if let userName = UserDefaults.standard.string(forKey: "userName") {
                    cell.cellSubTitleLabel.text = userName
                } else {
                    cell.cellSubTitleLabel.text = "사용자 이름"
                }
            }
        } else {
            cell.cellSubTitleLabel.text = ""
        }
        return cell
    }
}
