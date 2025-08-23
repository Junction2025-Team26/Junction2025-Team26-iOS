//
//  InsightViewModel.swift
//  SyncTank
//
//  Created by Demian Yoo on 8/23/25.
//

import SwiftUI

@MainActor
final class InsightViewModel: ObservableObject {
    enum Tab: String, CaseIterable { case plans = "Urgent", insight = "Insight" }
    
    @Published var isFetching: Bool = false
    @Published var minSkeletonShown: Bool = false
    @Published var fetchSuccessText: String? = nil
    
    @Published var selected: Tab = .plans
    @Published var page: Int = 0
    @Published var items: [DashItem] = []
    @Published var isLoading = false
    
    let pageSize = 6   // 3열 × 2행
    
    var filtered: [DashItem] {
        switch selected {
        case .plans: return items.filter { $0.kind == .plan }
        case .insight: return items.filter { $0.kind == .insight }
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
    
    func remove(_ item: DashItem) {
        withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
            items.removeAll { $0.id == item.id }
        }
        page = min(page, max(0, pageCount - 1))
    }
    
    
    func testPostToSavedocs(with url: URL) {
        Task {
            guard let payload = makeBase64PreviewPayload(from: url) else {
                print("❌ base64 생성 실패")
                return
            }
            let sample = DashItemRequest(
                id: UUID().uuidString,
                content: "string",
                attachment: payload.toRequest()
            )
            do {
                let response = try await APIService.shared.saveDocs(sample)
                print("✅ POST 성공: \(response)")
            } catch {
                print("❌ 실패: \(error)")
            }
        }
    }
    
    func fetchAllDocs() async {
        isFetching = true
        minSkeletonShown = false
        
        async let delay: Void = {
            try? await Task.sleep(nanoseconds: 2_000_000_000) // 2초
            await MainActor.run { self.minSkeletonShown = true }
        }()
        
        async let fetch: Void = {
            do {
                let docs = try await APIService.shared.fetchDocs()
                await MainActor.run {
                    // 디버깅 로그 추가
                    print(" 받아온 데이터 개수: \(docs.count)")
                    for (index, doc) in docs.enumerated() {
                        print("📱 [\(index)] ID: \(doc.id), Kind: \(doc.kind), Title: \(doc.title)")
                    }
                    
                    withAnimation {
                        self.items = docs
                    }
                    
                    // 필터링된 데이터 확인
                    print("🔍 Urgent 탭 데이터: \(self.items.filter { $0.kind == .plan }.count)개")
                    print("🔍 Insight 탭 데이터: \(self.items.filter { $0.kind == .insight }.count)개")
                    
                    self.fetchSuccessText = "요청이 완료되었습니다 ✅"
                }
            } catch {
                print("❌ Fetch 실패: \(error.localizedDescription)")
            }
        }()
        
        _ = await (delay, fetch)
        
        isFetching = false
    }
    
    @MainActor
    func uploadAndRefresh(text: String, attachment: AttachmentPayload?) async {
        do {
            let request = DashItemRequest(
                id: UUID().uuidString,
                content: text.isEmpty ? "No message" : text,
                attachment: attachment?.toRequest()
            )
            
            let result = try await APIService.shared.saveDocs(request)
            print("✅ 저장 성공: \(result)")
            
            await fetchAllDocs()  // 서버 기준으로 다시 가져오기
        } catch {
            print("❌ 저장 실패: \(error)")
        }
    }
}
