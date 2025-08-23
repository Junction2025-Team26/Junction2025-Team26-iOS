//
//  Endpoints.swift
//  SyncTank-iOS
//
//  Created by Demian Yoo on 8/23/25.
//

import Foundation

enum API {
    static let baseURL = URL(string: "http://3.39.148.133:8000")!

    enum Path {
        static let saveDocs = "/savedocs"
        static let fetchDocs = "/fetchdocs"
    }
}
