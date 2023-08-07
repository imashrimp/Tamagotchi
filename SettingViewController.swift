//
//  SettingViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SettingViewController: UIViewController {
    
    let cellItem = SettingItemlList()
    
    @IBOutlet var settingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        setNavBar()
        
        self.view.backgroundColor = Design.backgroundColor
        settingTableView.backgroundColor = Design.backgroundColor
        
        settingTableView.rowHeight = 70
        
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: "SettingTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingTableView.reloadData()
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangeUserNameViewController") as! ChangeUserNameViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectTamagotchiViewController") as! SelectTamagotchiViewController
            
        //1. 넘길때 다마고치 변경화면 설정을 위한 식별자
            vc.mode = .change
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 2 {

            let alert = UIAlertController(title: "데이터 초기화", message: #""확인"버튼을 누르면 데이터가 초기화 됩니다. "#, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let okay = UIAlertAction(title: "확인", style: .default) { okay in
                UserDefaults.standard.set(false, forKey: "launched")
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "SelectTamagotchiViewController") as! SelectTamagotchiViewController
                let nav = UINavigationController(rootViewController: vc)

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell") as! SettingTableViewCell
        
        cell.setUIContents(item: cellItem.list[indexPath.row])
        
        if indexPath.row == 0 {
            
            if let userName = UserDefaults.standard.string(forKey: "userName") {
                cell.cellSubTitleLabel.text = userName
            } else {
                cell.cellSubTitleLabel.text = "사용자 이름"
            }
        } else {
            cell.cellSubTitleLabel.text = ""
        }
        return cell
    }
}
