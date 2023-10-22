/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum // 스크럼 바인딩
    @StateObject var scrumTimer = ScrumTimer() // 스크럼타이머 @StateObject프로퍼티 추가
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor) // scrum이 범위에 없어서 바인딩 해줘야함.
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme) // scrumTimer를 사용하는 미팅헤더 하위 뷰에 추가
                Circle()
                    .strokeBorder(lineWidth: 24)
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor) // ZStack 테마 악센트컬러 설정
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            // 타이머는 Meeting 인스턴스가 화면에 표시될 때마다 재설정되며, 이는 회의가 시작되어야 함을 나타냄
            scrumTimer.startScrum() // 타이머가 재설정된 후 scrum.startScrum()을 호출하여새 스크럼 타이머를 시작시킴.
        }
        .onDisappear() {
            scrumTimer.stopScrum() // 타이머는 Meeting 인스턴스가 화면을 떠날 때마다 멈추고, 회의가 끝났다는 것을 나타냄
        }
        .navigationBarTitleDisplayMode(.inline) // 내비게이션 바 제목 표시 모드를 .inline 설정
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
