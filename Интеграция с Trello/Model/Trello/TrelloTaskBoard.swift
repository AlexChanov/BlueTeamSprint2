//
//  TaskBoard.swift
//  AppStructure
//
//  Created by VadimQw  on 14/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

public struct TrelloTaskBoard {
    
    public var id: String
    public var name: String
    public var isClosed: Bool
    
    public var dto: TrelloTaskBoardDTO {
        var dto = TrelloTaskBoardDTO()
        dto.id = id
        dto.name = name
        dto.closed = isClosed
        return dto
    }
    
    
    init(dto: TrelloTaskBoardDTO) {
        id = dto.id ?? ""
        name = dto.name ?? "Неизвестно"
        isClosed = dto.closed ?? true
    }
    
}
