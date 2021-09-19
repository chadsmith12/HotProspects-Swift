//
//  ProspectsStore.swift
//  HotProspects
//
//  Created by Chad Smith on 9/17/21.
//

import CodeScanner
import Foundation

class ProspectsStore : ObservableObject {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    private let prospectService: ProspectService
    private var offsetsToDelete: IndexSet?
    @Published private(set) var prospects: [Prospect]
    @Published var isShowingScanner = false
    @Published var isShowingReminderSheet = false
    @Published var isShowingDeletion = false
    @Published var selectedFilter = FilterType.none
    
    init() {
        prospectService = ProspectService()
        prospects = prospectService.getProspects()
    }
    
    func addProspect(name: String, email: String) {
        let prospect = Prospect(name: name, email: email, isContacted: false)
        prospects.append(prospect)
    }
    
    func confirmDeleteProspects(at offsets: IndexSet) {
        isShowingDeletion = true
        offsetsToDelete = offsets
    }
    
    func deleteProspects() {
        guard let offsetsToDelete = offsetsToDelete else { return }
        prospects.remove(atOffsets: offsetsToDelete)
    }
    
    func filterProspects(by filterType: FilterType) -> [Prospect] {
        switch filterType {
        case .none:
            return self.prospects
        case .contacted:
            return self.prospects.filter { prospect in
                prospect.isContacted
            }
        case .uncontacted:
            return self.prospects.filter { prospect in
                !prospect.isContacted
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
        case .success(let code):
            print(code)
            let components = code.components(separatedBy: "\n")
            guard components.count == 2 else { return }
            let prospect = Prospect(name: components[0], email: components[1], isContacted: false)
            prospects.append(prospect)
            prospectService.save(prospects: prospects)
        case.failure(let error):
            print("Something failed \(error.localizedDescription)")
        }
        
        isShowingScanner = false
    }
    
    func getContextTitle(prospect: Prospect) -> String {
        prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted"
    }
    
    func toggleContacted(for prospect: Prospect) {
        let index = prospects.firstIndex { currentProspect in
            currentProspect.id == prospect.id
        }
        guard let index = index else { return }
        
        prospects[index].toggleContacted()
        prospectService.save(prospects: prospects)
    }
    
    func scheduleNotificationReminder(prospect: Prospect) {
        prospectService.tryScheduleNotification(for: prospect)
    }
}
