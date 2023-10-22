//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/22/23.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int // seconds에 대한 속성을 만들고 프리뷰에서
    let secondsRemaining: Int // 새 인수를 이니셜라이저에 전달.
    let theme: Theme // Theme 추가
    
    private var totalSeconds: Int { // totalSeconds라는 계산 속성을 추가
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        // totalSeconds가 0보다 크면 secondsElapsed / totalSconds 하고 그게 아니면 1을 리턴
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
        // VoiceOver 사용자는 진행상황을 볼 수 없기에 몇초에서 분으로의 변환을 계산하고 가장 관련성이 높은 데이터인 남은 분을 표시
    }
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("10 minutes") // 접근성 추가
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal]) // 최상위 VStack 간격을 조정하기 위해 상단과 수평 패딩을 추가
    }
}

#Preview {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
        .previewLayout(.sizeThatFits)
}
