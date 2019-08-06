//
//  File.swift
//  News
//
//  Created by Doaa Tantawy on 8/6/19.
//  Copyright © 2019 Doaa Tantawy. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
