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

class ChordPair: NSObject, NSCoding {
    private let first, second: Chord
    
    override var hashValue: Int {
        return first.hashValue ^ second.hashValue
    }
    
    init?(_ first: Chord, _ second: Chord) {
        guard first != second else {
            return nil
        }
        
        (self.first, self.second) = (first, second)
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(first.rawValue, forKey: "first")
        aCoder.encodeObject(second.rawValue, forKey: "second")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let first = Chord(rawValue: aDecoder.decodeObjectForKey("first") as! String),
            let second = Chord(rawValue: aDecoder.decodeObjectForKey("second") as! String)
            else { return nil }
        
        self.init(first, second)
    }
}

// MARK: Equatable
func == (lhs: ChordPair, rhs: ChordPair) -> Bool {
    return Set<Chord>([lhs.first, lhs.second]) == Set<Chord>([rhs.first, rhs.second])
}

class ChangeRecord: NSObject, NSCoding {
    // MARK: Properties
    let numChanges : Int
    let date : NSDate
    
    init(_ numChanges: Int, date: NSDate = NSDate()) {
        self.numChanges = numChanges
        self.date = date
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(numChanges, forKey: "numChanges")
        aCoder.encodeObject(date, forKey: "date")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObjectForKey("date") as? NSDate else { return nil }
        
        let numChanges = aDecoder.decodeIntegerForKey("numChanges")
        
        self.init(numChanges, date: date)
    }
}

func getChordPairsFor(stage: Int) -> Set<ChordPair> {
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
    
    return chordPairs
}


class User: NSObject, NSCoding {
    // MARK: Properties
    var pic: UIImage?
    var oneMinChanges = [ChordPair:[ChangeRecord]]()
    private(set) var stage: Int = 0
    
    init(pic: UIImage? = UIImage(named: "headshot"), oneMinChanges: [ChordPair:[ChangeRecord]] = [:], stage: Int = 1) {
        self.pic = pic
        self.oneMinChanges = oneMinChanges
        self.stage = stage
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Methods
    func incrementStage() {
        stage += 1
        
        // Add chord pairs and empty record list to dictionary if entry doesn't exist
        let chordPairs = getChordPairsFor(stage)
        chordPairs.forEach({
            if oneMinChanges[$0] == nil {
                oneMinChanges[$0] = []
            }
        })
    }
    
    func updateRecord(chordPair: ChordPair, record: ChangeRecord) {
        oneMinChanges[chordPair]?.append(record)
    }
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.pic, forKey: "photo")
        coder.encodeObject(self.oneMinChanges, forKey: "changes")
        coder.encodeObject(self.stage, forKey: "stage")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let pic = decoder.decodeObjectForKey("photo") as? UIImage,
            let oneMinChanges = decoder.decodeObjectForKey("changes") as? [ChordPair:[ChangeRecord]]
            else { return nil }
        
        let stage = decoder.decodeIntegerForKey("stage")
        
        self.init(pic: pic, oneMinChanges: oneMinChanges, stage: stage)
    }
}




















































