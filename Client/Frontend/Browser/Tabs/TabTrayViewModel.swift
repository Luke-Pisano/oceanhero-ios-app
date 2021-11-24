/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Shared
import Storage

class TabTrayViewModel {

    let profile: Profile
    let tabManager: TabManager

    // Tab Tray Views
    let tabTrayView: TabTrayViewDelegate

    init(tabTrayDelegate: TabTrayDelegate? = nil, profile: Profile, showChronTabs: Bool = false) {
        self.profile = profile
        self.tabManager = BrowserViewController.foregroundBVC().tabManager

        if showChronTabs {
            self.tabTrayView = ChronologicalTabsViewController(tabTrayDelegate: tabTrayDelegate, profile: self.profile)
        } else {
            self.tabTrayView = GridTabViewController(tabManager: self.tabManager, profile: profile, tabTrayDelegate: tabTrayDelegate)
        }
    }

    func navTitle(for segmentIndex: Int, foriPhone: Bool) -> String? {
        if foriPhone {
            switch segmentIndex {
            case 0, 1:
                return Strings.TabTrayV2Title
            default:
                return nil
            }
        }
        return nil
    }
}

// MARK: - Actions
extension TabTrayViewModel {
    @objc func didTapDeleteTab(_ sender: UIBarButtonItem) {
        tabTrayView.performToolbarAction(.deleteTab, sender: sender)
    }

    @objc func didTapAddTab(_ sender: UIBarButtonItem) {
        tabTrayView.performToolbarAction(.addTab, sender: sender)
    }
}