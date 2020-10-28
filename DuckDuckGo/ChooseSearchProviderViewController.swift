//
//  ChooseSearchProviderViewController.swift
//  DuckDuckGo
//
//  Created by Mariusz on 19/10/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit
import Core

class ChooseSearchProviderViewController: UIViewController {
    private lazy var searchProviderStore: SearchProviderStore = SearchProviderUserDefaults()
    private var providers: [RadioButton] = []
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var oceanHeroProvider: RadioButton!
    @IBOutlet weak var microsoftProvider: RadioButton!
    @IBOutlet weak var googleProvider: RadioButton!
    @IBOutlet weak var yahooProvider: RadioButton!
    
    var onChooseSearchProviderCompleted: (() -> Void)?
    
    var activeSearchProvider: SearchProvider = .oceanHero {
        didSet {
            update()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseButton.layer.cornerRadius = 25
        chooseButton.layer.masksToBounds = true
        
        closeButton.isHidden = !isModal
        
        topLabel.text = UserText.chooseSearchProviderTopTitle
        bottomLabel.text = UserText.chooseSearchProviderBottomTitle
        chooseButton.setTitle(UserText.chooseSearchProviderButtonTitle, for: .normal)
        
        setupProviders()
        setupActiveProvider()
        update()
    }
}

extension ChooseSearchProviderViewController {
    private func setupProviders() {
        oceanHeroProvider.tag = SearchProvider.oceanHero.rawValue
        oceanHeroProvider.title = SearchProvider.oceanHero.title
        oceanHeroProvider.icon = SearchProvider.oceanHero.icon
        oceanHeroProvider.iconSize = SearchProvider.oceanHero.size
        oceanHeroProvider.onChangeActiveState = { [weak self] provider in
            self?.onChangeActiveSearchProvider(provider)
        }
        
        microsoftProvider.tag = SearchProvider.microsoft.rawValue
        microsoftProvider.title = SearchProvider.microsoft.title
        microsoftProvider.icon = SearchProvider.microsoft.icon
        microsoftProvider.iconSize = SearchProvider.microsoft.size
        microsoftProvider.onChangeActiveState = { [weak self] provider in
            self?.onChangeActiveSearchProvider(provider)
        }
        
        googleProvider.tag = SearchProvider.google.rawValue
        googleProvider.title = SearchProvider.google.title
        googleProvider.icon = SearchProvider.google.icon
        googleProvider.iconSize = SearchProvider.google.size
        googleProvider.onChangeActiveState = { [weak self] provider in
            self?.onChangeActiveSearchProvider(provider)
        }
        
        yahooProvider.tag = SearchProvider.yahoo.rawValue
        yahooProvider.title = SearchProvider.yahoo.title
        yahooProvider.icon = SearchProvider.yahoo.icon
        yahooProvider.iconSize = SearchProvider.yahoo.size
        yahooProvider.onChangeActiveState = { [weak self] provider in
            self?.onChangeActiveSearchProvider(provider)
        }
        
        providers = [oceanHeroProvider, microsoftProvider, googleProvider, yahooProvider]
    }
    
    private func setupActiveProvider() {
        guard let searchProvider = SearchProvider(rawValue: searchProviderStore.searchProvider) else {
            return
        }
        
        activeSearchProvider = searchProvider
    }
    
    private func onChangeActiveSearchProvider(_ provider: RadioButton) {
        guard let searchProvider = SearchProvider(rawValue: provider.tag) else {
            return
        }
        
        activeSearchProvider = searchProvider
    }
    
    private func update() {
        providers.forEach { provider in
            provider.isActive = activeSearchProvider.rawValue == provider.tag
        }
    }
}

extension ChooseSearchProviderViewController {
    @IBAction func chooseButtonTouched(_ sender: Any) {
        searchProviderStore.searchProvider = activeSearchProvider.rawValue
        onChooseSearchProviderCompleted?()
    }
    
    @IBAction func skipButtonTouched(_ sender: Any) {
        onChooseSearchProviderCompleted?()
    }
}
