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
    
    private var board = TrelloTaskBoard(dto: TrelloTaskBoardDTO())
    
    // =
    
    private func getBoard() {
        let session = URLSession.shared
        let boardTask = session.dataTask(with: TrelloRequestManager.shared.getBoard()) { (data, response, error) in
            do {
                let boards = try JSONDecoder().decode([TrelloTaskBoardDTO].self, from: data!)
                let board = boards.map { TrelloTaskBoard(dto: $0) }.filter { !$0.isClosed }.first
                guard let b = board else { return }
                self.board = b
                self.getLists()
            } catch { print(error) }
        }
        boardTask.resume()
    }
    
    private func getLists() {
        let session = URLSession.shared
        let listsTask = session.dataTask(with: TrelloRequestManager.shared.getLists(for: self.board.id)) { (data, response, error) in
            do {
                let lists = try JSONDecoder().decode([TrelloTaskListDTO].self, from: data!)
                let _lists = lists.map { TrelloTaskList(dto: $0) }.filter { !$0.isClosed }
                self.board.lists = _lists
            } catch { print(error) }
        }
        listsTask.resume()
    }
    
    public func updateTaskBoard() {
        getBoard()
    }
    
}



// MARK: - NSCopying
extension TrelloManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
