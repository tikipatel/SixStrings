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

struct ChordPair: Equatable, Hashable {
    private let first, second: Chord
    
    var hashValue: Int {
        return first.hashValue ^ second.hashValue
    }
    
    init?(_ first: Chord, _ second: Chord) {
        guard first != second else {
            return nil
        }
        
        (self.first, self.second) = (first, second)
    }
}

// MARK: Equatable
func == (lhs: ChordPair, rhs: ChordPair) -> Bool {
    return Set<Chord>([lhs.first, lhs.second]) == Set<Chord>([rhs.first, rhs.second])
}

ChordPair(Chord.A, Chord.B7) == ChordPair(Chord.C, Chord.C7)
ChordPair(Chord.A, Chord.B7) == ChordPair(Chord.A, Chord.B7)

ChordPair(Chord.A, Chord.B7)

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
    
}

var me = User()

me.pic = UIImage(named: "headshot")


func getChordPairsForStage(stage: Int) -> [ChordPair] {
    var allChords = [Chord]()
    var chordPairs = Set<ChordPair>()
    
    for i in 1...stage {
        if let chords = Chord.chordsForStage[i] {
            allChords.appendContentsOf(chords)
        }
    }
    
    for first in allChords {
        for second in allChords {
            if let pair = ChordPair(first, second) {
                chordPairs.insert(pair)
            }
            
        }
    }
    
    return Array(chordPairs)
}

getChordPairsForStage(2)