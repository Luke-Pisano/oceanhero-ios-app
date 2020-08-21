//
//  ServiceClient.swift
//  Core
//
//  Created by Cezary Bielecki on 18/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Alamofire
import Foundation
import Core

#warning("It's a temporary solution for a fast working version. In the future please use standard API Client/API Parser/API service architecture")

class ServiceClient {
    func getCurrentBottleCount(onComplete: @escaping ((Int) -> Void)) {
        let request = Alamofire.request(AppUrls().counterAPICall)

        request.responseJSON { response in
            if let result = response.result.value {
                guard let JSON = result as? NSDictionary, let counter = JSON["counter"] as? Int else {
                    onComplete(41090673)
                    return
                }

                onComplete(counter)
            }
        }
    }
}
