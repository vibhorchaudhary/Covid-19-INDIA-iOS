//
//  CovidDataModel.swift
//  Covid19India
//
//  Created by Vibhor Chaudhary on 01/04/20.
//  Copyright © 2020 Vibhor Chaudhary. All rights reserved.
//

import Foundation

class CovidDataModel: Codable {
    var cases_time_series:[CasesTimeSeriesModel]?
    var key_values:[KeyValuesModel]?
    var statewise:[StateWiseModel]?
}
