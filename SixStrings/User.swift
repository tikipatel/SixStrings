//
//  User.swift
//  SixStrings
//
//  Created by Sean Johnsen on 5/10/16.
//  Copyright © 2016 Sean Johnsen. All rights reserved.
//

import UIKit
import Foundation

enum Chord: String {
    case D
    case A
    case E
    case Amin
    case Emin
    case Dmin
    case G
    case C
    case G7
    case C7
    case B7
    case Fmaj7
    case A7
    case D7
    case E7
    case F
    case Asus2
    case Asus4
    case Dsus2
    case Dsus4
    case Esus4
    case BigG
//    case RockG
//    case FolkG
}

struct ChordPair {
    private let chords : Set<Chord>
    
    init?(first: Chord, second: Chord) {
        
        guard first == second else {
            return nil
        }

        self.chords = [first, second]
    }
}

struct ChangeRecord {
    let numChanges : Int
    let date : NSDate
}

struct OneMinuteChange {
    let chordPair : ChordPair
    var changeRecords = [ChangeRecord]()
}

class User {
    // MARK: Properties
    var pic : UIImage?
    var oneMinChanges = [OneMinuteChange]()
    var stage : Int = 1
    
    static let chordsForStage = [1: [Chord.D, Chord.A, Chord.E],
                                 2: [Chord.Amin, Chord.Emin, Chord.Dmin],
                                 3: [Chord.G, Chord.C],
                                 4: [Chord.G7, Chord.C7, Chord.B7, Chord.Fmaj7],
                                 5: [Chord.A7, Chord.D7, Chord.E7],
                                 6: [Chord.F],
                                 7: [Chord.Asus2, Chord.Asus4, Chord.Dsus2, Chord.Dsus4, Chord.Esus4],
                                 8: [Chord.BigG]]
//                                 8: [Chord.BigG, Chord.RockG, Chord.FolkG]]
}