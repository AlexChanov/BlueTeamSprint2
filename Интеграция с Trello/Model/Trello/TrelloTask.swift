//
//  Task.swift
//  AppStructure
//
//  Created by VadimQw  on 14/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

public struct TrelloTask {
    
    public var id: String
    public var name: String
    public var text: String
    public var isClosed: Bool
    public var idList: String
    public var idBoard: String
    
    public var dto: TrelloTaskDTO {
        var dto = TrelloTaskDTO()
        dto.id = id
        dto.name = name
        dto.desc = text
        dto.closed = isClosed
        dto.idList = idList
        dto.idBoard = idBoard
        return dto
    }
    
    
    init(dto: TrelloTaskDTO) {
        id = dto.id ?? ""
        name = dto.name ?? "Неизвестно"
        text = dto.desc ?? ""
        isClosed = dto.closed ?? true
        idList = dto.idList ?? ""
        idBoard = dto.idBoard ?? ""
    }
    
    init(name: String) {
        self.id = ""
        self.name = name
        self.text = ""
        self.isClosed = false
        self.idList = ""
        self.idBoard = ""
    }
    
}
