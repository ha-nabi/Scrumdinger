//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/22/23.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker] // 스피커 프로퍼티 추가
    var skipAction: () -> Void
    
    private var speakerNumber: Int? { // 스피커 번호를 결정하는 계산 프로퍼티 추가
        guard let index = speakers.firstIndex(where: { !$0.isCompleted}) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool { // 활성화된 스피커가 마지막 스피커인지 확인하는 계산 프로퍼티 추가
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String { // 활성화된 스피커에 대한 정보를 반환하는 계산 프로퍼티를 추가하고 텍스트 보기 추가.
        guard let speakerNumber = speakerNumber else { return "No more speakers"}
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker { // 스피커가 마지막 스퍼커인 경우 텍스트 표시
                    Text("Last Speaker")
                } else {
                    Text(speakerText) // 18번째 줄
                    Spacer()
                    Button(action: skipAction) { // skipAction 업데이트
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal]) // 최상위 VStack 하단 및 수평 패딩 추가
    }
}

#Preview {
    MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
    // 스피커 프로퍼티 프리뷰 연결
        .previewLayout(.sizeThatFits)
}
