//
//  TaskList.swift
//  AppStructure
//
//  Created by VadimQw  on 14/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

public struct TrelloTaskList {
    
    public var id: String
    public var name: String
    public var isClosed: Bool
    public var idBoard: String
    
    public var tasks: [TrelloTask] = []
    
    public var dto: TrelloTaskListDTO {
        var dto = TrelloTaskListDTO()
        dto.id = id
        dto.name = name
        dto.closed = isClosed
        dto.idBoard = idBoard
        return dto
    }
    
    
    init(dto: TrelloTaskListDTO) {
        id = dto.id ?? ""
        name = dto.name ?? "Неизвестно"
        isClosed = dto.closed ?? true
        idBoard = dto.idBoard ?? ""
    }
    
}
