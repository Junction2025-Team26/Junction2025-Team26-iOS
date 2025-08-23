//
//  PlanModels.swift
//  SyncTank
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

enum ItemKind: String, Codable { case photo, plan, file }

struct DashItem: Identifiable, Codable, Hashable {
    let id: UUID
    let kind: ItemKind
    let title: String
    let subtitle: String
    let thumbnailName: String?   // photo/card 썸네일 (Assets 이름)
    let fileBadge: String?       // "PDF" 등

    init(id: UUID = .init(), kind: ItemKind,
         title: String, subtitle: String,
         thumbnailName: String? = nil, fileBadge: String? = nil) {
        self.id = id
        self.kind = kind
        self.title = title
        self.subtitle = subtitle
        self.thumbnailName = thumbnailName
        self.fileBadge = fileBadge
    }
}

extension Array where Element == DashItem {
    static let demo: [DashItem] = [
        .init(kind: .plan,  title: "Don't forget your dinner.", subtitle: "You have a dinner appointment with your friend at 7 p.m. on August 24th."),
        .init(kind: .plan,  title: "Deadline approaching.", subtitle: "Submit the final report by 5 p.m. this Friday."),
        .init(kind: .file,  title: "A new PDF has been saved.", subtitle: "Marketing strategy document uploaded on August 23rd.", fileBadge: "PDF"),
        .init(kind: .photo, title: "Design file detected.", subtitle: "Wireframe update received from the design team.", fileBadge: "PNG"),
        .init(kind: .file,  title: "Code snippet stored.", subtitle: "API integration script dropped into your workspace.", fileBadge: "PDF"),
        .init(kind: .plan,  title: "Don't lose this idea", subtitle: "“What if we merge the onboarding and tutorial screens into one?”")
    ]
}
