//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Chad Smith on 9/17/21.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {
    @EnvironmentObject var prospectStore: ProspectsStore
    
    var filteredProspects: [Prospect] {
        prospectStore.filterProspects(by: prospectStore.selectedFilter)
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Contacted Filter Selection", selection: $prospectStore.selectedFilter) {
                    Text("Everyone").tag(ProspectsStore.FilterType.none)
                    Text("Contacted").tag(ProspectsStore.FilterType.contacted)
                    Text("Not Contacted").tag(ProspectsStore.FilterType.uncontacted)
                }
                .pickerStyle(SegmentedPickerStyle())
                List {
                    ForEach(filteredProspects) { prospect in
                        ProspectRow(prospect: prospect)
                    }
                    .onDelete(perform: prospectStore.confirmDeleteProspects)
                }
            }
            .navigationTitle("Prospects")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.prospectStore.isShowingScanner = true
                    }, label: {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                    })
                }
            }
            .sheet(isPresented: $prospectStore.isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Chad Smith\nsmith.chad12@gmail.com", completion: prospectStore.handleScan)
            }
            .actionSheet(isPresented: $prospectStore.isShowingDeletion) {
                ActionSheet(title: Text("Delete Prospect"), message: Text("Are you sure you want to delete this prospect?"), buttons: [.destructive(Text("Remove"), action: prospectStore.deleteProspects), .cancel()])
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView()
            .environmentObject(ProspectsStore())
    }
}
