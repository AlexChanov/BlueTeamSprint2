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
        case trelloToken
    }
    
    
    public func setTrelloToken(_ token: String) {
        set(token, forKey: UserDefaultsKeys.trelloToken.rawValue)
        synchronize()
    }
    
    public func getTrelloToken() -> String {
        return string(forKey: UserDefaultsKeys.trelloToken.rawValue) ?? ""
    }
    
    public func isLoggedIn() -> Bool {
        return getTrelloToken() != ""
    }
    
    public func deleteTrelloToken() {
        setTrelloToken("")
    }
    
}
