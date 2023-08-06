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
        
        if indexPath.row == 0 {         /// 사용자 이름 변경 화면 전환
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangeUserNameViewController") as! ChangeUserNameViewController
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 1 { // 다마고치 변경 화면 전환
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "SelectTamagotchiViewController") as! SelectTamagotchiViewController
            
            // UserDefaults 사용해서 최초 앱 실행인 경우와 아닌 경우로 구분해야함 이 값을 여기서 설정해야하는지는 잘 모르겟음.
            
            vc.mode = .change
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else if indexPath.row == 2 {

            let alert = UIAlertController(title: "데이터 초기화", message: #""확인"버튼을 누르면 데이터가 초기화 됩니다. "#, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let okay = UIAlertAction(title: "확인", style: .default) // 여기에 클로저 추가해야함
            // okay의 클로저에서는 데이터를 초기화 하는 기능이 구현되면 됨.
            // selectTamagotchiVC로 돌아가며 시작화면 전환 UserDefaults 값 바꾸고
            // UserDefautls에 저장되어있는 다마고치의 모든 값 날리기
            
            alert.addAction(cancel)
            alert.addAction(okay)
            // 팝업 화면의 확인버튼의 경우에는 앱 최초 실행시에는 Main화면으로 push, 변경의 경우에는 루트뷰 변경 작동하게 구현해 MainVC로 화면전환 되도록
            
            present(alert, animated: true)
            
            //=> 쉽게 말하면 앱 최초 실행상태로 돌리면 됨
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
            // 이게 아니면 애초에
            if let userName = UserDefaults.standard.string(forKey: "userName") {
                cell.cellSubTitleLabel.text = userName
            } else {
                cell.cellSubTitleLabel.text = cellItem.list[0].subtitle
            }
        } else {
            cell.cellSubTitleLabel.text = ""
        }
        return cell
    }
}
