//
//  Bundle+icon.swift
//  Bundle+icon
//
//  Created by Shun Kashiwa on 2021/08/27.
//

import Foundation
import UIKit

extension Bundle {

  public var icon: UIImage? {

    if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
       let primary = icons["CFBundlePrimaryIcon"] as? [String: Any],
       let files = primary["CFBundleIconFiles"] as? [String],
       let icon = files.last {
      return UIImage(named: icon)
    }

    return nil
  }
}
