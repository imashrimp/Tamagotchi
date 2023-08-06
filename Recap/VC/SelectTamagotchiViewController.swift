//
//  SelectTamagotchiViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SelectTamagotchiViewController: UIViewController {
    
//    var identifier: // 이거는 열거형 사용해서 최초 선택이랑, 변경이랑 구분되도록
    
    ///이 프로퍼티 사용해서 네비게이션 타이틀이랑 didSelect메서드에서 뜨는 팝업창의 버튼 달라질거임.
    var mode: SelectTamagochiMode?
    
    let tamagotchiList = TamagotchiList()
    let settingList = SettingItemlList()
    
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

        self.navigationItem.title = "대장님의 다마고치"
        self.view.backgroundColor = Design.backgroundColor
        self.tamagochiCollectionView.backgroundColor = Design.backgroundColor
    }
}

extension SelectTamagotchiViewController: UICollectionViewDelegate {
    
    // 시작화면 변경을 여기서 구현해야함
    // 이 메서드도 최초 선택이랑, 변경 시랑 identifer 사용해서 alert이 다르게 실행되도록
    // alert 실행 시 클로저 사용해야함.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if tamagotchiList.tamagotchi[indexPath.row].type == TamagotchiSpecies.none.rawValue {
            // 여기서 타마고치의 이름이 ""이면
            //레벨1: 화면전환 안되게
            //레벨2: 타마고치 생성 화면으로 전환
            
            let alert = UIAlertController(title: "알림", message: "다마고치가 준비되지 않았습니다.", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okay)
            
            present(alert, animated: true)
            
        } else {
            
            UserDefaults.standard.set(true, forKey: "launched")

            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            let nav = UINavigationController(rootViewController: vc)
            
            //팝업창 띄워서 확인 버튼 눌렀을 때 UserDefaults에 객체를 저장하고 MainVC에서는 이걸 불러오자
            
            let selectedTamagotchi = tamagotchiList.tamagotchi[indexPath.row]

//            let encoder = JSONEncoder()
//
//            //트라이가 뭘하는가? 찾아보자
//            if let encoded = try? encoder.encode(selectedTamagotchi) {
//                // 키값 바꿔야함 객체 고유의 ID로
//                UserDefaults.standard.set(encoded, forKey: "encoded")
//            }
            Methods.saveTamagotchiStruct(tamagotchi: selectedTamagotchi, key: "ID")
            
            vc.myTamagotchi = Methods.loadTamagotchiStruct(key: "ID")
            
            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
            
            
        }
//        vc.myTamagotchi = tamagotchiList.tamagotchi[indexPath.row]
        // UserDefaults는 구조체 타입을 아카이빙 언 아카이빙을 통해 저장 가능함 (https://ios-development.tistory.com/702)
        // 그리고 UserDefualts에서 구조체 타입의 데이터를 불러올 때 키 값을 셀의 index로 하자 그러면 다마고치를 변경을 위해 셀을 누를 때 그 셀의 index를 키 값으로 받는 함수를 선언해 불러오면 됨. => 그러면 이게 변경된게 MainVC에서 보여질 때도, viewDidLoad에서 객체(변경된거, 처음에 설정한거, 앱 종료 후 재실행 경우)를 불러오는 메서드를 호출하면 됨.(아마 이 메서드에서는 키값을 설정하는게 중요할 듯.)
        // MainVC에서는 앱 실행시 작동하는 AppDelegate에 이는 메서드에서 객체가 설정되도록 해볼까?
        
        
        
//        present(nav, animated: true)
    }
}

extension SelectTamagotchiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchiList.tamagotchi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TamagotchiCollectionViewCell", for: indexPath) as! TamagotchiCollectionViewCell
        
        
//        cell.setTamagotchiImage(data: tamagotchiList.tamagotchi[indexPath.row])
        
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
