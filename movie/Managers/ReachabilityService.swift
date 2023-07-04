//
//  ReachabilityService.swift
//  movie
//
//  Created by Prox on 05/07/2023.
//

import Foundation
import Reachability
import RxSwift
import RxCocoa

protocol ReachabilityServiceDelegate : NSObjectProtocol {
    func reachabilityChanged(connectionType: Reachability.Connection)
}

class ReachabilityService : NSObject {
    /** `Singleton` */
    static let shared               = ReachabilityService()
    var reachability                : Reachability?
    let prefixLog                   = "🎯 ReachabilityService 🎯"
    weak var delegate               : ReachabilityServiceDelegate?
    
    /// `Observe` biến `Rx` này để lắng nghe sự thay đổi `Reachability`
    var rxConnectionType            = BehaviorRelay<Reachability.Connection?>(value: nil)
    
    private override init() {}
    
    // MARK: - Initialized VNPT ReachabilityService
    /** IMPORTANT: Need to init when application started */
    func initialedReachability() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        do {
            try self.reachability = Reachability()
            try self.reachability?.startNotifier()
        } catch {
            print(error)
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        self.delegate?.reachabilityChanged(connectionType: reachability.connection)
        self.rxConnectionType.accept(reachability.connection)
    }
    
    func isConnectionEnable() -> Bool {
        return [Reachability.Connection.cellular, Reachability.Connection.wifi].contains(self.rxConnectionType.value)
    }
}
