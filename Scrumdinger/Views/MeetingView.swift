/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum // 스크럼 바인딩
    @StateObject var scrumTimer = ScrumTimer() // 스크럼타이머 @StateObject프로퍼티 추가
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer}
    // avp 관련 프로퍼티
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor) // scrum이 범위에 없어서 바인딩 해줘야함.
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme) // scrumTimer를 사용하는 미팅헤더 하위 뷰에 추가
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
                // MeetingFooterView 추가하고, speakers 와 sipAction 추가
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor) // ZStack 테마 악센트컬러 설정
        .onAppear {
            startScrum() // 새로운 함수를 만들고 새 함수 호출
        }
        .onDisappear() {
            endScrum() // 새로운 함수를 만들고 새 함수 호출
        }
        .navigationBarTitleDisplayMode(.inline) // 내비게이션 바 제목 표시 모드를 .inline 설정
    }
    
    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        // 타이머는 Meeting 인스턴스가 화면에 표시될 때마다 재설정되며, 이는 회의가 시작되어야 함을 나타냄
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play() // 오디오파일 재생
        } // ScrumTimer의 시간이 만료되면 player.play() 호출. ( 효과음 )
        scrumTimer.startScrum() // 타이머가 재설정된 후 scrum.startScrum()을 호출하여새 스크럼 타이머를 시작시킴.
    }
    
    private func endScrum() {
        scrumTimer.stopScrum() // 타이머는 Meeting 인스턴스가 화면을 떠날 때마다 멈추고, 회의가 끝났다는 것을 나타냄
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
        // onDisappear(perform:)가 뷰가 사라질 때 클로저를 실행하는 이벤트에 대한 응답에서 리콜
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
