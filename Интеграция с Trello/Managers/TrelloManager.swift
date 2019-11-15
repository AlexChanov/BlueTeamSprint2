//
//  TrelloManager.swift
//  AppStructure
//
//  Created by VadimQw  on 14/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import Foundation

public final class TrelloManager {
    
    public static let shared = TrelloManager()
    
    private init() { }
    
    // =
    
    private let apiKey = "ea07aac585af78ec74a3c2c3ec7976da"
    
    // =
    
    public func authorizationRequest() -> URLRequest {
        let url = URL(string: "https://trello.com/1/authorize?" + "expiration=never" + "&scope=read,write" +
                                                            "&name=Board" + "&response_type=token" + "&key=\(apiKey)")!
        return URLRequest(url: url)
    }
    
    public func getTaskBoard() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://api.trello.com/1/members/me/boards?" + "key=\(apiKey)" +
                                                    "&token=\(UserDefaults.standard.getTrelloToken())")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                let boards = try JSONDecoder().decode([TrelloTaskBoardDTO].self, from: data!)
                
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}



// MARK: - NSCopying
extension TrelloManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
