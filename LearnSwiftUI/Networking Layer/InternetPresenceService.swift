//
//  InternetPresenceService.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 22/09/23.
//

import Network
import Combine
class InternetPresenceService {
    var internetCheckPublisher = PassthroughSubject<Bool, Never>()
    
    internal init(internetCheckPublisher: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()) {
        self.internetCheckPublisher = internetCheckPublisher
        monitorInternet()
    }
    func monitorInternet() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let this = self else {return}
            if path.status == .satisfied {
                this.internetCheckPublisher.send(true)
                monitor.cancel()
            } else {
                this.internetCheckPublisher.send(false)
                monitor.cancel()
            }
        }
    }
}
