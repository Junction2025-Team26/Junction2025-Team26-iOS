//
//  View+.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//
import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
