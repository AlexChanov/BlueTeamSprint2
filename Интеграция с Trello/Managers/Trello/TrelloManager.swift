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
    
    var delegate: TrelloManagerDelegate?
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
                self.getTasks()
            } catch { print(error) }
        }
        listsTask.resume()
    }
    
    private func getTasks() {
        let session = URLSession.shared
        let tasksTask = session.dataTask(with: TrelloRequestManager.shared.getTasks(for: self.board.id)) { (data, response, error) in
            do {
                let tasks = try JSONDecoder().decode([TrelloTaskDTO].self, from: data!)
                let _tasks = tasks.map { TrelloTask(dto: $0) }.filter { !$0.isClosed }
                for list in self.board.lists {
                    var index = 0
                    for task in _tasks {
                        if list.id == task.idList {
                            self.board.lists[index].tasks.append(task)
                        }
                    }
                    index += 1
                }
                self.delegate?.update(self.board)
            } catch { print(error) }
        }
        tasksTask.resume()
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
