//
//  HelperUserDefaults.swift
//  Audible
//
//  Created by XCodeClub on 2019-10-21.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private enum UserDefaultsKeys: String {
        case isLoggedIn
    }
    
    
    public func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    public func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
}
