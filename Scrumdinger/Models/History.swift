//
//  History.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/23/23.
//

import Foundation

struct History: Identifiable { //히스토리 구조체는 화면 섹션의 필수 세부 정보를 저장하는 속성
    let id: UUID
    let date: Date
    let attendees: [DailyScrum.Attendee]
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        // 각 속성에 대한 기본 매개 변수를 제공하는 이니셜라이저
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
