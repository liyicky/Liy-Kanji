//
//  EnvironmentVariables.swift
//  Liy-Kanji
//
//  Created by Jason Cheladyn on 2022/04/21.
//

import Foundation
import SwiftUI

// MARK: - Go Back Button Environment Vairable
private struct GoBackKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var goBack: Bool {
        get { self[GoBackKey.self] }
        set { self[GoBackKey.self] = newValue }
    }
}

extension View {
    func goBack(_ goBack: Bool) -> some View {
        environment(\.goBack, goBack)
    }
}
