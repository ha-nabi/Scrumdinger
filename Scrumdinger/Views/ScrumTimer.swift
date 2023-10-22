//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by 강치우 on 10/22/23.
//

import SwiftUI

class ScrumTimer: ObservableObject {
    @Published var activeSpeaker = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemainin = 0
}
