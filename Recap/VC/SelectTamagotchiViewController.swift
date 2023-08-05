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
    
    // 이 메서드도 최초 선택이랑, 변경 시랑 identifer 사용해서 alert이 다르게 실행되도록
    // alert 실행 시 클로저 사용해야함.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let alert = UIAlertController(title: "", message: "다마고치 이름 넣어서 메세지 작성", preferredStyle: .alert)
//
//        let start = UIAlertAction(title: "시작하기", style: .default)
//        let cancel = UIAlertAction(title: "취소", style: .default) { done in
//            return
//        }
//
//        alert.addAction(cancel)
//        alert.addAction(start)
//
//
//
////        alert.setValue(UIImage(named: TamagotchiImageSingleton.shared.cactus.eight), forKey: "cactusEight")
//        present(alert, animated: true)
    }
        
        
}

extension SelectTamagotchiViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TamagotchiCollectionViewCell", for: indexPath) as! TamagotchiCollectionViewCell
        
        cell.contentsConfigure(data: tamagotchiList.tamagochi[0])
        
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
