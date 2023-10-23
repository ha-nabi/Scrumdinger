//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/23/23.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumView: Bool
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum) // 디테일에딧트뷰에 뉴스크럼 바인딩 전달
                .toolbar { // Detail 추가 버튼 도구 추가
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum) // add 버튼 액션에 newScrum 추가
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData), isPresentingNewScrumView: .constant(true)) // 바인딩 추가한 프로퍼티들 프리뷰 넣기.
}
