//
//  BottleCounter.swift
//  DuckDuckGo
//
//  Created by Mariusz on 26/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import Core

class BottleCounter {
    private lazy var appSettings: AppSettings = AppUserDefaults() 
    private lazy var apiClient = APIClient(apiService: APIService(baseURL: AppUrls().counterAPICall), apiParser: APIParser())
    
    private var userBottleCounter: Int = 0
    private var startBottleCounter: Int = 0
    private var currentBottleCounter: Int = 0
    
    private var stepDuration = 0.05
    private let animationTime = 1
    
    private var timer: Timer?
    private var bottleTimer: Timer?
    private var isStarted: Bool = false
    
    private let numberFormatter = NumberFormatter()
    
    private var stepsCount: Int {
        return Int(Double(animationTime) / stepDuration)
    }
    
    private var finalBottleCounter: Int {
        get {
            let value = appSettings.currentBottleCounter
            
            guard value == 0 else {
                return value
            }
            
            return 0
        }
        
        set {
            appSettings.currentBottleCounter = newValue
        }
    }
    
    var currentValue: String {
        guard let value = numberFormatter.string(from: NSNumber(value: currentBottleCounter)) else {
            return ""
        }
        
        return value
    }
    
    var didUpdatedTotalBottle: ((String) -> Void)?
    
    // MARK: - Init
    
    init() {
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        numberFormatter.groupingSeparator = ","
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        bottleTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true, block: { [weak self] _ in
            self?.checkBottleCount()
        })
    }
}

extension BottleCounter {
    func start() {
        isStarted = true
        
        if appSettings.animationFromCurrentBottleCounterValue {
            startBottleCounter = finalBottleCounter
            currentBottleCounter = finalBottleCounter
        } else {
            appSettings.animationFromCurrentBottleCounterValue = true
            startBottleCounter = 0
            currentBottleCounter = 0
        }
        
        didUpdatedTotalBottle?(currentValue)
        startTotalCounterAnimation()
        checkBottleCount()
    }
    
    func refresh() {
        startTotalCounterAnimation()
        checkBottleCount()
    }
    
    func stop() {
        isStarted = false
        bottleTimer?.invalidate()
        timer?.invalidate()
    }
}

extension BottleCounter {
    private func checkBottleCount() {
        _ = apiClient.request(routerType: RouterType.bottleCount, onSuccess: { [weak self] (response: BottleCountResponse) in
            guard let selfStrong = self else {
                return
            }
            
            selfStrong.finalBottleCounter = response.counter / 5
            selfStrong.startBottleCounter = selfStrong.currentBottleCounter
            
            guard selfStrong.isStarted else {
                return
            }
            
            DispatchQueue.main.async {
                selfStrong.startTotalCounterAnimation()
            }
        }, onFailure: { error in
            print("error: \(error)")
        })
    }
    
    private func startTotalCounterAnimation() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: stepDuration, repeats: true) { [weak self] _ in
            guard let selfStrong = self else {
                return
            }
            
            guard selfStrong.currentBottleCounter < selfStrong.finalBottleCounter else {
                selfStrong.currentBottleCounter = selfStrong.finalBottleCounter
                selfStrong.didUpdatedTotalBottle?(selfStrong.currentValue)
                selfStrong.timer?.invalidate()
                
                return
            }
            
            var incrementation = (selfStrong.finalBottleCounter - selfStrong.startBottleCounter ) / selfStrong.stepsCount
            
            if incrementation == 0 {
                incrementation = 1
            }
            
            selfStrong.didUpdatedTotalBottle?(selfStrong.currentValue)
            selfStrong.currentBottleCounter += incrementation
        }
    }
}
