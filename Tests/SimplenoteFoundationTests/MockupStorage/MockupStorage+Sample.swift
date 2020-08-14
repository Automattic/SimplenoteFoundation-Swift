import Foundation
import CoreData
@testable import SimplenoteFoundation


// MARK: - MockupStorage Sample Entity Insertion Methods
//
extension MockupStorageManager {

    /// Inserts a new (Sample) Note into the receiver's Main MOC
    ///
    @discardableResult
    func insertSampleNote(contents: String = "") -> MockupNote {
        guard let note = NSEntityDescription.insertNewObject(forEntityName: MockupNote.entityName, into: viewContext) as? MockupNote else {
            fatalError()
        }

        note.modificationDate = Date()
        note.creationDate = Date()
        note.content = contents

        return note
    }

    /// Inserts a new (Sample) Tag into the receiver's Main MOC
    ///
    @discardableResult
    func insertSampleTag(name: String = "") -> MockupTag {
        guard let tag = NSEntityDescription.insertNewObject(forEntityName: MockupTag.entityName, into: viewContext) as? MockupTag else {
            fatalError()
        }

        tag.name = name

        return tag
    }
}
