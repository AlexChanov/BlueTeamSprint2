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
    
    private init() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        self.session = session
    }
    
    // =
    
    private let session: URLSession
    private var board = TrelloTaskBoard(dto: TrelloTaskBoardDTO())
    
    
    // MARK: - Tasks
    
    private var boardTask: URLSessionDataTask!
    
    
    // MARK: - Public functions
    
    public func initTask() {
        self.boardTask = session.dataTask(with: TrelloRequestManager.shared.getBoard()) { (data, response, error) in
            do {
                let boards = try JSONDecoder().decode([TrelloTaskBoardDTO].self, from: data!)
                let board = boards.map { TrelloTaskBoard(dto: $0) }.filter { !$0.isClosed }.first
                guard let b = board else { return }
                self.board = b
            } catch { print(error) }
        }
    }
    
    public func getTaskBoard() {
        boardTask.resume()
    }
    
}



// MARK: - NSCopying
extension TrelloManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
