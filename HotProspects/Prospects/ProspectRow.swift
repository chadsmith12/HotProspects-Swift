//
//  ProspectRow.swift
//  HotProspects
//
//  Created by Chad Smith on 9/18/21.
//

import SwiftUI

struct ProspectRow: View {
    @EnvironmentObject var prospectStore: ProspectsStore
    var prospect: Prospect
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(prospect.name)
                .font(.headline)
            Text(prospect.email)
                .foregroundColor(.secondary)
        }
        .contextMenu {
            Button(prospectStore.getContextTitle(prospect: prospect)) {
                self.prospectStore.toggleContacted(for: prospect)
            }
            if !prospect.isContacted {
                Button("Remind Me") {
                    self.prospectStore.isShowingReminderSheet = true
                }
                Button("Contact \(prospect.name)") {
                    self.prospectStore.isShowingMail = true
                }
            }
        }
        .actionSheet(isPresented: $prospectStore.isShowingReminderSheet) {
            ActionSheet(title: Text("Schedule Reminder"), message: Text("Are you sure you want to schedule a reminder?"), buttons: [.default(Text("Schedule Reminder"), action: {
                prospectStore.scheduleNotificationReminder(prospect: prospect)
            }), .cancel()])
        }
        .sheet(isPresented: $prospectStore.isShowingMail) {
            MailView(data: .constant(prospect.mailData)) { result in
                switch result {
                case .success(let result):
                    if result == .sent {
                        self.prospectStore.toggleContacted(for: prospect)
                    }
                    break
                case .failure(_):
                    break
                }
            }
        }
    }
}

struct ProspectRow_Previews: PreviewProvider {
    static var previews: some View {
        ProspectRow(prospect: Prospect(name: "Test", email: "example@example.com", isContacted: false))
            .environmentObject(ProspectsStore())
    }
}
