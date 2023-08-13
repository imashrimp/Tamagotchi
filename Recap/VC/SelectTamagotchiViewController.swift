//
//  SelectTamagotchiViewController.swift
//  Recap
//
//  Created by 권현석 on 2023/08/04.
//

import UIKit

class SelectTamagotchiViewController: UIViewController {

    var mode: SelectTamagochiMode = .firstChoice
    
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
        setTamagotchiList()
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
            for i in 0..<tamagotchiList.count {
                let myTamago = Methods.loadTamagotchiStruct(key: i)
                         if myTamago.rice != tamagotchiList[i].rice || myTamago.water != tamagotchiList[i].water {
                    tamagotchiList.remove(at: i)
                    tamagotchiList.insert(myTamago, at: i)
                }
            }
        }
    }
}

extension SelectTamagotchiViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if mode == .firstChoice {
            
            if tamagotchiList[indexPath.row].type == TamagotchiSpecies.none.rawValue {
                
                okayOnlyAlert(alertTitle: "알림", alertMessage: "다마고치가 준비되지 않았습니다.")
                
            } else {
                
                let sb = UIStoryboard(name: StoryboardName.popUp.rawValue, bundle: nil)
                
                let popUpVC = sb.instantiateViewController(withIdentifier: VCName.PopUp.rawValue ) as! PopUpViewController
                
                popUpVC.modalPresentationStyle = .overFullScreen
                
                popUpVC.selectedTamago = tamagotchiList[indexPath.row]
                
                present(popUpVC, animated: true)
            }
        } else {
            
            if tamagotchiList[indexPath.row].type == TamagotchiSpecies.none.rawValue {
                
                okayOnlyAlert(alertTitle: "알림", alertMessage: "다마고치가 준비되지 않았습니다.")
                
            } else {
                // 여기가 안됨
                //다마고치 데이터 모델이 갖고 있는 id와 UserDefaults에서 갖고 있는 id가 같으면 얼럿을 띄운다
                //그렇다면 이 시점 이전에 UserDefaults에 "ID"라는 키로 저장된 값이 있음. 이걸 찾아라 => popUp에 전달된 값에서 "ID"값을 저장함.
                if tamagotchiList[indexPath.row].id == UserDefaults.standard.integer(forKey: TamagoID.shared.id) {
                    
                    okayOnlyAlert(alertTitle: "알림", alertMessage: "다마고치가 준비되지 않았습니다.")
                    
                } else {
                    
                    let sb = UIStoryboard(name: StoryboardName.popUp.rawValue, bundle: nil)
                    
                    let popUpVC = sb.instantiateViewController(withIdentifier: VCName.PopUp.rawValue) as! PopUpViewController
                    
                    popUpVC.modalPresentationStyle = .overFullScreen
                    
                    popUpVC.selectedTamago = tamagotchiList[indexPath.row]
                    
                    present(popUpVC, animated: true)
                }
            }
        }
    }
}

extension SelectTamagotchiViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tamagotchiList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellName.selectTamagoCell.rawValue, for: indexPath) as! TamagotchiCollectionViewCell
        
        if mode == .firstChoice {
            
            var myTamgotichLevel: Int {
                return Int(((tamagotchiList[indexPath.row].rice / 5) + (tamagotchiList[indexPath.row].water / 2)) / 10)            }
            
            Methods.showTamagotchiImage(imageView: cell.tamagotchiImage, tamagotchiType: tamagotchiList[indexPath.row].type, level: myTamgotichLevel)
            
            
            cell.labelSetting(data: tamagotchiList[indexPath.row])
            
            return cell
        } else {
            
            var myTamgotichLevel: Int {
                return Int(((tamagotchiList[indexPath.row].rice / 5) + (tamagotchiList[indexPath.row].water / 2)) / 10)
            }
            
            Methods.showTamagotchiImage(imageView: cell.tamagotchiImage, tamagotchiType: tamagotchiList[indexPath.row].type, level: myTamgotichLevel)
            
            cell.labelSetting(data: tamagotchiList[indexPath.row])
            
            return cell
        }
    }
}

//MARK: - flowLayout 메서드 익스텐션
extension SelectTamagotchiViewController: CollectionCellContentsConfigure {
    
    func setNib() {
        let nib = UINib(nibName: CellName.selectTamagoCell.rawValue, bundle: nil)
        tamagochiCollectionView.register(nib, forCellWithReuseIdentifier: CellName.selectTamagoCell.rawValue)
    }
    
    func cellFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        let width = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        
        layout.itemSize = CGSize(width: width, height: width + 40)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        tamagochiCollectionView.collectionViewLayout = layout
    }
}
