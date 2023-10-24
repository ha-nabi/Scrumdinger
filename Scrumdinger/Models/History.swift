//
//  History.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/23/23.
//

import Foundation
// Codable: 외부 표현으로 전환 할 수 있는 유형
// Identifiable: List, ForEach 처럼 데이터를 나열하는 뷰 또는
// alert, actionSheet 처럼 화면을 띄울 항목을 정확히 구분지어야 할 때 쓰는 유형
struct History: Identifiable, Codable { //히스토리 구조체는 화면 섹션의 필수 세부 정보를 저장하는 속성
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
