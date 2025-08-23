//
//  InsightViewModel.swift
//  SyncTank
//
//  Created by Demian Yoo on 8/23/25.
//

import SwiftUI

@MainActor
final class InsightViewModel: ObservableObject {
    enum Tab: String, CaseIterable { case all = "All", plans = "Plans", insight = "Insight" }

    @Published var selected: Tab = .all
    @Published var page: Int = 0
    @Published var items: [DashItem] = .demo

    let pageSize = 6   // 3열 × 2행

    var filtered: [DashItem] {
        switch selected {
        case .all:   return items
        case .plans: return items.filter { $0.kind == .plan }
        case .insight: return items.filter { $0.kind == .file || $0.kind == .photo }
        }
    }

    var pageCount: Int {
        let c = filtered.count
        return max(1, Int(ceil(Double(c) / Double(pageSize))))
    }

    var pageItems: [DashItem] {
        let start = page * pageSize
        let end = min(filtered.count, start + pageSize)
        guard start < end else { return [] }
        return Array(filtered[start..<end])
    }

    func goPrev() { page = max(0, page - 1) }
    func goNext() { page = min(pageCount - 1, page + 1) }

    func categoryOnChangeTab(_ t: Tab) {
        selected = t
        page = 0
    }
}
