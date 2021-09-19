//
//  ProspectService.swift
//  HotProspects
//
//  Created by Chad Smith on 9/18/21.
//

import Foundation
import NotificationCenter

struct ProspectService {
    static let ProspectKey = "SavedProspects"
    
    func getProspects() -> [Prospect] {
        if let data = UserDefaults.standard.data(forKey: Self.ProspectKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                return decoded
            }
        }
        
        return []
    }
    
    func save(prospects: [Prospect]) {
        if let encoded = try? JSONEncoder().encode(prospects) {
            UserDefaults.standard.set(encoded, forKey: Self.ProspectKey)
        }
    }
    
    func buildNotification(for prospect: Prospect) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Contact \(prospect.name)"
        content.subtitle = prospect.email
        content.sound = UNNotificationSound.default
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 9
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        return UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    }
    
    func tryScheduleNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                center.add(buildNotification(for: prospect))
            }
            else {
                center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                    if success {
                        center.add(buildNotification(for: prospect))
                    }
                }
            }
        }
    }
}
