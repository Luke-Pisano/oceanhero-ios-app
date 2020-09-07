//
//  BottleCountResponse.swift
//  Core
//
//  Created by Mariusz on 04/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation

public class BottleCountResponse: Decodable {
    public let counter: Int
    public let counterLastWeek: Int
}
