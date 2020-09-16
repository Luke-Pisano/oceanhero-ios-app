//
//  UserHomeSectionRenderer.swift
//  DuckDuckGo
//
//  Created by Mariusz on 16/09/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import UIKit
import Core

class UserHomeSectionRenderer: HomeViewSectionRenderer {
    var controller: HomeViewController?
    
    func install(into controller: HomeViewController) {
        self.controller = controller
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userHomeCell",
                                                            for: indexPath) as? UserHomeCell else {
            fatalError("not an Extra Content cell")
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

        return CGSize(width: width, height: 120)
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
