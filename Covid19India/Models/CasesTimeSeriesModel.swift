//
//  CasesTimeSeriesModel.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 01/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import Foundation

class CasesTimeSeriesModel: Codable {
    var dailyconfirmed:String?
    var dailydeceased:String?
    var dailyrecovered:String?
    var date:String?
    var totalconfirmed:String?
    var totaldeceased:String?
    var totalrecovered:String?
}
