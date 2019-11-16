//
//  TrelloRequestManager.swift
//  AppStructure
//
//  Created by VadimQw  on 15/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import Foundation

public final class TrelloRequestManager {
    
    public static let shared = TrelloRequestManager()
    
    private init() { }
    
    // =
    private let apiKey = "ea07aac585af78ec74a3c2c3ec7976da"
    private var token: String {
        get { return UserDefaults.standard.getTrelloToken() }
    }
    
    // =
    public func authorization() -> URLRequest {
        let url = URL(string: "https://trello.com/1/authorize?expiration=never&scope=read,write&name=Board&response_type=token&key=\(apiKey)")!
        return URLRequest(url: url)
    }
    
    public func deleteToken() -> URLRequest {
        let url = URL(string: "https://api.trello.com/1/tokens/\(token)/?key=\(apiKey)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        return request
    }
    
    public func getBoard() -> URLRequest {
        let url = URL(string: "https://api.trello.com/1/members/me/boards?key=\(apiKey)&token=\(token)")!
        return URLRequest(url: url)
    }
    
    public func getLists(for boardID: String) -> URLRequest {
        let url = URL(string: "https://api.trello.com/1/boards/\(boardID)/lists?key=\(apiKey)&token=\(token)")!
        return URLRequest(url: url)
    }
    
    public func getTasks(for boardID: String) -> URLRequest {
        let url = URL(string: "https://api.trello.com/1/boards/\(boardID)/cards?key=\(apiKey)&token=\(token)")!
        return URLRequest(url: url)
    }
    
    public func addTask(for listID: String, name: String) -> URLRequest {
        let url = URL(string: "https://api.trello.com/1/cards?idList=\(listID)&keepFromSource=all&name=\(name)&key=\(apiKey)&token=\(token)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
	
	public func addList(for boardID: String, name: String) -> URLRequest {
		let url = URL(string: "https://api.trello.com/1/lists?name=\(name)&idBoard=\(boardID)&key=\(apiKey)&token=\(token)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
	}
    
//    public func deleteTask(for taskID: String) -> URLRequest {
//        let url = URL(string: "https://api.trello.com/1/cards/\(taskID)?key=\(apiKey)&token=\(token)")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        return request
//    }
}

// MARK: - NSCopying
extension TrelloRequestManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
