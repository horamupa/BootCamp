//
//  ObserverBootcamp.swift
//  BootCamp
//
//  Created by MM on 20.06.2023.
//

import SwiftUI

//All observers need that
protocol Observer {
    func getNew(video: String)
}

protocol Subject {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notification(video: String)
}

// Subject of Observation
class Blogger: Subject {
    var observers = NSMutableSet()
    var video: String = "" {
        didSet {
            notification(video: video)
        }
    }
    
    func add(observer: Observer) {
        observers.add(observer)
    }
    
    func remove(observer: Observer) {
        observers.remove(observer)
    }
    
    func notification(video: String) {
        for observer in observers {
            (observer as! Observer).getNew(video: video)
        }
    }
}

class Subscriber: NSObject, Observer {
    var nickName: String
    
    init(nickName: String) {
        self.nickName = nickName
    }
    
    func getNew(video: String) {
        print("Пользователь \(nickName) получил новое видео \(video)")
    }
}

class Google: NSObject, Observer {
    func getNew(video: String) {
        print("Видео \(video) обрабатывается")
    }
}

class MainEngine {
    let main = Blogger()
    let sub1 = Subscriber(nickName: "Rome")
    let sub2 = Subscriber(nickName: "Nikola")
    let sub3 = Google()
    
    func go() {
        main.add(observer: sub1)
        main.add(observer: sub2)
        main.add(observer: sub3)
        main.notification(video: "Gorbachev")
    }
}

