//
//  ViewController.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 01/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var confirmedLabel: UILabel!
    
    @IBOutlet weak var confirmedCountLabel: UILabel!
    
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var activeCountLabel: UILabel!
    
    @IBOutlet weak var recoveredLabel: UILabel!
    
    @IBOutlet weak var recoveredCountLabel: UILabel!
    
    @IBOutlet weak var deathLabel: UILabel!
    
    @IBOutlet weak var deathCountLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func onRefreshClicked(_ sender: Any) {
        fetchDataFromServerAndUpdateUi()
    }
    
    var covidData:CovidDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isHidden = true
        
        
        fetchDataFromServerAndUpdateUi()
    }
    
    
    func fetchDataFromServerAndUpdateUi() {
        let observable = getLiveDataFromServer()
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        
        observable.subscribe(onNext: { (covidDataModel) in
            debugPrint("onNext called")
            self.covidData = covidDataModel
            self.setDataOnUi(covidDataModel)
            
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            
            if self.covidData?.statewise != nil {
                
                if(self.covidData!.statewise![0].state!.elementsEqual("Total")) {
                    self.covidData?.statewise?.remove(at: 0)
                }
            }
            
            
        }, onError: { (error) in
            debugPrint("onError called")
            debugPrint(error)
        }, onCompleted: {
            debugPrint("onCompleted called")
        }) {
            debugPrint("onDisposed called")
        }
    }
    
    func getLiveDataFromServer() -> Observable<CovidDataModel> {
        return Observable<CovidDataModel>.create { observer in
            
            let requestResponse = AF.request(Constants.COVID_19_URL).responseJSON { (response) in
                do {
                    let covidModelData = try JSONDecoder().decode(CovidDataModel.self, from: response.data ?? Data())
                    observer.onNext(covidModelData)
                } catch let error {
                    debugPrint(error)
                }
            }
            return Disposables.create {
                requestResponse.cancel()
            }
        }
        
    }
    
    
    func setDataOnUi(_ covidData:CovidDataModel) {
        debugPrint(covidData)
        confirmedLabel.text = "CONFIRMED"
        deathLabel.text = "DEATHS"
        activeLabel.text = "ACTIVE"
        recoveredLabel.text = "RECOVERED"
        
        let totalCountData:StateWiseModel = getTotalCountData(covidData.statewise!);
        
        confirmedCountLabel.text = totalCountData.confirmed
        deathCountLabel.text = totalCountData.deaths
        activeCountLabel.text = totalCountData.active
        recoveredCountLabel.text = totalCountData.recovered
        
    }
    
    func getTotalCountData(_ stateWiseDataList:[StateWiseModel]) -> StateWiseModel {
        var totalData:StateWiseModel?
        for totalDataModel in stateWiseDataList {
            if(totalDataModel.state != nil && ("TOTAL").caseInsensitiveCompare(totalDataModel.state!) == ComparisonResult.orderedSame) {
                totalData = totalDataModel
                break;
            }
        }
        return totalData!
    }
    
    
    // MARK: Collection view methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return covidData?.statewise?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statewisecell", for: indexPath) as! StateWiseCollectionViewCell
        
        let stateWiseModel = covidData?.statewise?[indexPath.row]
        
        guard stateWiseModel != nil else {
            return cell;
        }
        
        cell.activeLabel.text = "Active"
        cell.confirmedLabel.text = "Confirmed"
        cell.deathsLabel.text = "Deaths"
        cell.recoveredLabel.text = "Recovered"
        
        cell.activeCountLabel.text = stateWiseModel?.active
        cell.confirmedCountLabel.text = stateWiseModel?.confirmed
        cell.deathsCountLabel.text = stateWiseModel?.deaths
        cell.recoveredCountLabel.text = stateWiseModel?.recovered
        
        cell.stateNameLabel.text = stateWiseModel?.state
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
