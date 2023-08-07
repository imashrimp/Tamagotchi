//
//  SelectTamagotchiViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SelectTamagotchiViewController: UIViewController {
    
    ///이 프로퍼티 사용해서 네비게이션 타이틀이랑 didSelect메서드에서 뜨는 팝업창의 버튼 달라질거임.
    // change의 경우
    //1. 컬렉션 뷰에 뜰 데이터에 현재 다마고치의 데이터 까지 업데이트 되어 띄워져야함.
    //1-1. cellForItemAt이게 바뀌어야함.
    //1.2. didSelect의 alert도 바꿔야함
    //2. 현재 다마고치 선택은 막자
    //3. 다른 다마고치 선택 시 현재의 다마고치를 저장하고 새 다마고치를 불러오자 => 여기서 다마고치의 ID가 필요할 듯(데이터 모델에 포함된 형태 또는 싱글톤이 또는 타입프로퍼티로)
    var mode: SelectTamagochiMode?
    
    var tamagotchiList = TamagotchiList().tamagotchi
    
    @IBOutlet var tamagochiCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tamagochiCollectionView.dataSource = self
        tamagochiCollectionView.delegate = self
        
        configureView()
        setNib()
        cellFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavTitle()
    }
    
    func setNavTitle() {
        
        if mode == .firstChoice {
            self.navigationItem.title = "대장님의 다마고치"
        } else {
            self.navigationItem.title = "다마고치 변경하기"
        }
    }
    
    func configureView() {

        self.view.backgroundColor = Design.backgroundColor
        self.tamagochiCollectionView.backgroundColor = Design.backgroundColor
    }
    
    func setTamagotchiList() {
        if mode == .change {
            tamagotchiList = []
            for i in 0..<tamagotchiList.count {
                let tamago = Methods.loadTamagotchiStruct(key: i)
                tamagotchiList.append(tamago)
            }
            print("새로운 다마고치 리스트", tamagotchiList)
        }
    }
}

extension SelectTamagotchiViewController: UICollectionViewDelegate {
    
    // 시작화면과 변경을 여기서 구현해야함
    // 이 메서드도 최초 선택이랑, 변경 시랑 identifer 사용해서 alert이 다르게 실행되도록
    // alert 실행 시 클로저 사용해야함.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(tamagotchiList)
        
        
        if tamagotchiList[indexPath.row].type == TamagotchiSpecies.none.rawValue {//타입이 "논"이면
            // 여기서 타마고치의 이름이 ""이면
            //레벨1: 화면전환 안되게
            //레벨2: 타마고치 생성 화면으로 전환
            
            let alert = UIAlertController(title: "알림", message: "다마고치가 준비되지 않았습니다.", preferredStyle: .alert)
            
            let okay = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okay)
            
            present(alert, animated: true) //alert띄워서 선택 안됨을 알리고
            
        } else { //다마고치의 타입이 논이 아니면
            
            let alert = UIAlertController(title: "\"\(tamagotchiList[indexPath.row].name)\" 다마고치를 선택하겠습니까?", message: #""확인"을 누르면 선택이 됩니다."#, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            let okay = UIAlertAction(title: "확인", style: .default) { okay in
                UserDefaults.standard.set(true, forKey: "launched")

                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                let nav = UINavigationController(rootViewController: vc)
                
                //팝업창 띄워서 확인 버튼 눌렀을 때 UserDefaults에 객체를 저장하고 MainVC에서는 이걸 불러오자
                
                let selectedTamagotchi = self.tamagotchiList[indexPath.row]

                Methods.saveTamagotchiStruct(tamagotchi: selectedTamagotchi/*, key: "ID"*/)
                
                UserDefaults.standard.set(indexPath.row, forKey: "ID")
                
                vc.myTamagotchi = Methods.loadTamagotchiStruct(key: self.tamagotchiList[indexPath.row].id)
                
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            
            alert.addAction(cancel)
            alert.addAction(okay)
            
            present(alert, animated: true) //alert을 띄우고, alert의 "확인"버튼 눌렀을 때 시작화면이 MainVC로 전환되고, MainVC에 선택한 화면이 뜸
        }
    }
}

extension SelectTamagotchiViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchiList.count //기본으로 설정된 다마고치 데이터 모델의 숫자를 가져옴
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TamagotchiCollectionViewCell", for: indexPath) as! TamagotchiCollectionViewCell
        
        if mode == .firstChoice {
            //MARK: - 레벨 계산 여기서 하는거 좀 별론데
            
            var level: Int {
                return ((tamagotchiList[indexPath.row].rice / 5) + (tamagotchiList[indexPath.row].water / 2)) / 10
            }
            
            Methods.showTamagotchiImage(imageView: cell.tamagotchiImage, tamagotchiType: tamagotchiList[indexPath.row].type, level: level)

            
            cell.labelSetting(data: tamagotchiList[indexPath.row])
            
            return cell
        } else {
            
            var level: Int {
                return ((tamagotchiList[indexPath.row].rice / 5) + (tamagotchiList[indexPath.row].water / 2))
            }
            
            Methods.showTamagotchiImage(imageView: cell.tamagotchiImage, tamagotchiType: tamagotchiList[indexPath.row].type, level: level)
            
            cell.labelSetting(data: tamagotchiList[indexPath.row])
            
            return cell
        }
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
