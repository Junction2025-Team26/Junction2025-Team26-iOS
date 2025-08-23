//
//  PickerType.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//
import SwiftUI

enum PickerType: Identifiable {
    case camera, photo, file
    var id: String { String(describing: self) }
}

