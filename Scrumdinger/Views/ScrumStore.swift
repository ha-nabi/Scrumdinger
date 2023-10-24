//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/25/23.
//

import SwiftUI

@MainActor // 비동기 load() 메서드에서 게시된 스크럼 속성을 업데이트하려면 클래스를 @MainActor로 표시해야 함.
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = [] // dailyscrum 타입의 프로퍼티 생성
    
    private static func fileURL() throws -> URL { // 스크럼딩거는 사용자의 문서 폴더에 있는 파일에 스크럼을 로드하고 저장함. 그리고 그 파일에 더 편리하게 접근할 수 있는 기능을 추가.
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        // filemanager class 에 대한 공유 인스턴스를 사용하여 현재 사용자에 대한 문서 디렉토리의 위치를 가져옴.
            .appendingPathComponent("scrums.data")
        // appendingComponent를 호출하여 scrums.data 파일의 URL 반환.
    }
    
    func load() async throws { // load 비동기 함수 선언
        let task = Task<[DailyScrum], Error> { // 이후에 반환된 값에 오류를 포착할 수 있도록 작업을 let 상수에 저장
            // 매개 변수는 closure 컴파일러를 반환.
            let fileURL = try Self.fileURL() // task 클로저 내부에서, 파일 URL에 대한 로컬 상수를 만듬.
            guard let data = try? Data(contentsOf: fileURL) else { // / 파일 데이터를 선택적으로 로드(가드렛)
                return [] // 응용 프로그램이 처음 열려 있는 경우 데이터 파일이 존재하지 않기 때문에 빈 어레이를 반환하면 빈 어레이를 반환하면 빈 어레이를 반환함.
            }
            let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            // 데이터를 로컬 상수로 디코딩.
            return dailyScrums
            // 디코딩된 스크럼 배열을 반환.
            // 작업 종료에서 반환된 값은 작업이 완료되면 사용할 수 있음.
        }
        let scrums = try await task.value // try await 사용하여 작업이 완료될 때까지 기다린 뒤, scrums 상수에 값을 할당.
        self.scrums = scrums
    }
    
    func save(scrums: [DailyScrum]) async throws { // 인코딩 스크럼은 실패할 수 있으며, 발생하는 오류를 처리해야 함.
        let task = Task {
            let data = try JSONEncoder().encode(scrums) // 스크럼 데이터 인코딩
            let outfile = try Self.fileURL() // 파일 URL에 대한 상수
            try data.write(to: outfile) // 인코딩 된 데이터를 파일에 씀
        }
        _ = try await task.value // 작업을 기다리면 작업 내부에 발생한 모든 오류가 발신자에게 보고됨. 밑줄 문자는 당신이 task.value 결과에 관심이 없다는 것을 나타냄.
    }
}
