//
//  SelectTamagotchiViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SelectTamagotchiViewController: UIViewController {
    
//    var identifier: // 이거는 열거형 사용해서 최초 선택이랑, 변경이랑 구분되도록
    
    let tamagotchiList = TamagotchiList()
    
    @IBOutlet var tamagochiCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tamagochiCollectionView.dataSource = self
        tamagochiCollectionView.delegate = self
        
        configureView()
        setNib()
        cellFlowLayout()
    }
    
    func configureView() {
        title = "다마고치 선택하기"
        self.view.backgroundColor = Design.shared.backgroundColor
        self.tamagochiCollectionView.backgroundColor = Design.shared.backgroundColor
    }
}

extension SelectTamagotchiViewController: UICollectionViewDelegate {
    
    // 시작화면 변경을 여기서 구현해야함
    // 이 메서드도 최초 선택이랑, 변경 시랑 identifer 사용해서 alert이 다르게 실행되도록
    // alert 실행 시 클로저 사용해야함.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        
        vc.myTamagotchi = tamagotchiList.tamagotchi[indexPath.row]
        // UserDefaults는 구조체 타입을 아카이빙 언 아카이빙을 통해 저장 가능함 (https://ios-development.tistory.com/702)
        // 그리고 UserDefualts에서 구조체 타입의 데이터를 불러올 때 키 값을 셀의 index로 하자 그러면 다마고치를 변경을 위해 셀을 누를 때 그 셀의 index를 키 값으로 받는 함수를 선언해 불러오면 됨. => 그러면 이게 변경된게 MainVC에서 보여질 때도, viewDidLoad에서 객체(변경된거, 처음에 설정한거, 앱 종료 후 재실행 경우)를 불러오는 메서드를 호출하면 됨.(아마 이 메서드에서는 키값을 설정하는게 중요할 듯.)
        // MainVC에서는 앱 실행시 작동하는 AppDelegate에 이는 메서드에서 객체가 설정되도록 해볼까?
        
        
        
        present(nav, animated: true)
    }
}

extension SelectTamagotchiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchiList.tamagotchi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TamagotchiCollectionViewCell", for: indexPath) as! TamagotchiCollectionViewCell
        
        cell.setTamagotchiImage(data: tamagotchiList.tamagotchi[indexPath.row])
        print(tamagotchiList.tamagotchi[indexPath.row].name)
        cell.labelSetting(data: tamagotchiList.tamagotchi[indexPath.row])
        
        return cell
    }
    
    
}

//MARK: - flowLayout 메서드 익스텐션
extension SelectTamagotchiViewController: CollectionCellContentsConfigure {
    
    func setNib() {
        let nib = UINib(nibName: "TamagotchiCollectionViewCell", bundle: nil)
        tamagochiCollectionView.register(nib, forCellWithReuseIdentifier: "TamagotchiCollectionViewCell")
    }
    
    func cellFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        let width = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        
        layout.itemSize = CGSize(width: width, height: width + 40)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing) // bottom 바꿔야 할 수 있음.
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        tamagochiCollectionView.collectionViewLayout = layout
    }
}
