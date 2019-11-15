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
    public var idList: String
    public var idBoard: String
    
    public var dto: TrelloTaskDTO {
        var dto = TrelloTaskDTO()
        dto.id = id
        dto.name = name
        dto.desc = text
        dto.idList = idList
        dto.idBoard = idBoard
        return dto
    }
    
    
    init(dto: TrelloTaskDTO) {
        id = dto.id ?? ""
        name = dto.name ?? "Неизвестно"
        text = dto.desc ?? ""
        idList = dto.idList ?? ""
        idBoard = dto.idBoard ?? ""
    }
    
}
