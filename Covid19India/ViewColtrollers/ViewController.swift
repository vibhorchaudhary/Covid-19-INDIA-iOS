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

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var confirmedHead: UILabel!
    
    @IBOutlet weak var confirmedHeadCount: UILabel!
    
    @IBOutlet weak var recoveredHead: UILabel!
    
    @IBOutlet weak var recoveredHeadCount: UILabel!
    
    @IBOutlet weak var activeHead: UILabel!
    
    @IBOutlet weak var activeHeadCount: UILabel!
    
    @IBOutlet weak var deathsHead: UILabel!
    
    @IBOutlet weak var deathsHeadCount: UILabel!
    
    @IBOutlet weak var lastReportedCaseTime: UILabel!
    
    @IBAction func onRefreshClicked(_ sender: Any) {
        fetchDataFromServerAndUpdateUi()
    }
    
    var covidData:CovidDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.isHidden = true
        
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
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.isHidden = false
            self.tableView.reloadData()
            
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
        confirmedHead.text = "CONFIRMED"
        deathsHead.text = "DEATHS"
        activeHead.text = "ACTIVE"
        recoveredHead.text = "RECOVERED"
        lastReportedCaseTime.text = getLastReportedCaseTime(covidData.key_values!)
        
        let totalCountData:StateWiseModel = getTotalCountData(covidData.statewise!);
        
        confirmedHeadCount.text = totalCountData.confirmed
        deathsHeadCount.text = totalCountData.deaths
        activeHeadCount.text = totalCountData.active
        recoveredHeadCount.text = totalCountData.recovered
        
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
    
    func getLastReportedCaseTime(_ keyValuesModelList:[KeyValuesModel]) -> String {
        var lateUpdatedTime:String = "LAST REPORTED CASE - "
        for keyValuesModelData in keyValuesModelList {
            lateUpdatedTime += keyValuesModelData.lastupdatedtime!
            break;
        }
        return lateUpdatedTime;
    }
    
    
}


extension ViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stateWiseData:StateWiseModel = covidData!.statewise![indexPath.row]
        debugPrint("Clicked at \(indexPath.row), state \(String(describing: stateWiseData.state))")
        
        let popOverVC:PopupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        
        popOverVC.setData(stateWiseData: stateWiseData)
        
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
        
    }
    
}

extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        covidData!.statewise!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StateWiseCell = tableView.dequeueReusableCell(withIdentifier: "StateWiseCell", for: indexPath) as! StateWiseCell
        
        cell.setData(stateWiseDateModel: covidData!.statewise![indexPath.row])
        
        return cell
    }
    
}
