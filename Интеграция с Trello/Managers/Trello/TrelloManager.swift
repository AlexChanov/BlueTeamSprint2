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
    
    //
    var delegate: TrelloManagerDelegate?
    private var board = TrelloTaskBoard(dto: TrelloTaskBoardDTO())
    
	//
    public func updateTaskBoard() {
        getBoard()
    }
    
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
                var index = 0
                for list in self.board.lists {
                    for task in _tasks {
                        if list.id == task.idList {
                            self.board.lists[index].tasks.append(task)
                        }
                    }
                    index += 1
                }
                self.delegate?.updateBoard(with: self.board)
            } catch { print(error) }
        }
        tasksTask.resume()
    }
    
    public func addTask(for listID: String, name: String) {
        let session = URLSession.shared
        let addTask = session.dataTask(with: TrelloRequestManager.shared.addTask(for: listID, name: name))
        addTask.resume()
    }
    
	public func addList(for title: String, completion: @escaping (String) -> Void) {
		let session = URLSession.shared
		let addList = session.dataTask(with: TrelloRequestManager.shared.addList(for: board.id, name: title), completionHandler: {data, response, error in
			guard let data = data, error == nil else {return}
			do {
				let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
				let id = dictionary["id"] as! String
				completion(id)
			} catch let error as NSError {
                print(error)
            }
		})
		addList.resume()
	}
	
//    public func deleteTask(for taskID: String) {
//        let session = URLSession.shared
//        let deleteTask = session.dataTask(with: TrelloRequestManager.shared.deleteTask(for: taskID))
//        deleteTask.resume()
//    }
    
    public func deleteToken() {
        let session = URLSession.shared
        let deleteTokenTask = session.dataTask(with: TrelloRequestManager.shared.deleteToken())
        deleteTokenTask.resume()
    }
    
}



// MARK: - NSCopying
extension TrelloManager: NSCopying {
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}
