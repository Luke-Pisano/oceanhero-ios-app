//
//  AsksInstallWebApplicationHomeSectionRenderer.swift
//  DuckDuckGo
//
//  Created by Mariusz on 07/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit
import Core

class AsksInstallWebApplicationHomeSectionRenderer: HomeViewSectionRenderer {
    var controller: HomeViewController?
    private weak var asksInstallWebApplication: HomeAsksInstallWebApplication!
    
    init(asksInstallWebApplication: HomeAsksInstallWebApplication) {
        self.asksInstallWebApplication = asksInstallWebApplication
        
        self.asksInstallWebApplication.onChangedState = { [weak self] state in
            self?.controller?.collectionView.reloadSections([1])
        }
        
        self.asksInstallWebApplication.onHide = { [weak self] in
            print("--- onHide ---")
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.controller?.remove(strongSelf)
        }
    }
    
    func install(into controller: HomeViewController) {
        self.controller = controller
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "asksInstallWebApplication",
                                                            for: indexPath) as? AsksInstallWebApplicationHomeCell else {
            fatalError("not an Extra Content cell")
        }
        
        cell.state = asksInstallWebApplication.currentState
        
        cell.onLeftAction = { [weak self] _ in
            self?.asksInstallWebApplication.nextLeftAction()
        }
        
        cell.onRightAction = { [weak self] _ in
            self?.asksInstallWebApplication.nextRightAction()
        }
        
        return cell
    }
    
    static func sectionMargin(in collectionView: UICollectionView) -> CGFloat {
        let margin: CGFloat
        
        if isPad {
            margin = (collectionView.frame.width - CenteredSearchHomeCell.Constants.searchWidthPad) / 2
        } else {
            let defaultMargin = HomeViewSectionRenderers.Constants.sideInsets
            let landscapeMargin = (collectionView.frame.width - CenteredSearchHomeCell.Constants.searchWidth + defaultMargin) / 2
            margin = isPortrait ? defaultMargin : landscapeMargin
        }
        
        return margin
    }
    
    static func visibleMargin(in collectionView: UICollectionView) -> CGFloat {
        return sectionMargin(in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets? {
        let margin = type(of: self).sectionMargin(in: collectionView)
        
        return UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let preferredWidth = collectionView.frame.width - (HomeViewSectionRenderers.Constants.sideInsets * 2)
        
        let maxWidth = isPad ? CenteredSearchHomeCell.Constants.searchWidthPad : CenteredSearchHomeCell.Constants.searchWidth
        let width: CGFloat = min(preferredWidth, maxWidth)
        
        let height = heightForText(text: asksInstallWebApplication.currentState.title, font: UIFont.arialFont(ofSize: 18.0), width: width - 30)
        
        return CGSize(width: width, height: height + 90)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize? {
        return CGSize(width: 1, height: 13)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                               withReuseIdentifier: EmptyCollectionReusableView.reuseIdentifier,
                                                               for: indexPath)
    }
    
    func heightForText(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let constrainedSize = CGSize.init(width: width, height: CGFloat(MAXFLOAT))
        let attributesDictionary = [NSAttributedString.Key.font: font]
        let mutablestring = NSAttributedString(string: text, attributes: attributesDictionary)

        var requiredHeight = mutablestring.boundingRect(with: constrainedSize,
                                                        options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin),
                                                        context: nil)

        if requiredHeight.size.width > width {
            requiredHeight = CGRect(x: 0, y: 0, width: width, height: requiredHeight.height)
        }
        
        return requiredHeight.size.height
    }
}
