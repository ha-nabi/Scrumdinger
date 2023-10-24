/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase // scenePhase 값에 @Environment 속성을 추가함. 이 값을 관찰하고 비활성 상태가 되면 사용자 데이터를 저장할 수 있음.
    // @Environment: 뷰의 환경에서 값을 읽는 프로퍼티 래퍼
    @State private var isPresentingNewScrumView = false
    let saveAction: () -> Void // 화면 보기를 인스턴트화할 때 closure를 제공.
  
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true // plus 버튼에 대한 작업 추가. true 면 앱이 시트를 표시
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) { // 시트 수정자 추가
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) { phase in // 지정된 값이 변경될 때 onChange(of:perform:)를 사용하여 작업을 트리거 할 수 있음.
            if phase == .inactive { saveAction() } // 비활성 단계에서 이벤트가 더 이상 수신되지 않으며 사용자에게 사용할 수 없음. 장면이 비활성 단계에서 이동되면 saveAction을 호출.
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}
