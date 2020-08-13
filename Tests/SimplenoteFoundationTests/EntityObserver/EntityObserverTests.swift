import XCTest
import CoreData
@testable import SimplenoteFoundation


// MARK: - EntityObserverTests Unit Tests
//
class EntityObserverTests: XCTestCase {

    /// InMemory Storage!
    ///
    private let storage = MockupStorageManager()

    /// Returns the NSMOC associated to the Main Thread
    ///
    private var viewContext: NSManagedObjectContext {
        storage.persistentContainer.viewContext
    }

    /// Verifies that EntityObserver picks changes affecting the observed entity
    ///
    func testEntityObserverDetectsChangesAffectingObservedEntity() {
        let note = storage.insertSampleNote()
        try? viewContext.save()

        let observer = EntityObserver(context: viewContext, object: note)

        let delegate = MockupObserverDelegate()
        observer.delegate = delegate

        XCTAssertEqual(delegate.modifiedIdentifiers, nil)

        note.content = "123"
        XCTAssertEqual(delegate.modifiedIdentifiers, nil)

        try? viewContext.save()
        XCTAssertEqual(delegate.modifiedIdentifiers?.count, 1)
    }
}


// MARK: - MockupObserver
//
class MockupObserverDelegate: EntityObserverDelegate {
    var modifiedIdentifiers: Set<NSManagedObjectID>?

    func entityObserver(_ observer: EntityObserver, didObserveChanges identifiers: Set<NSManagedObjectID>) {
        modifiedIdentifiers = identifiers
    }
}
