# SimplenoteFoundation

This Package offers tools required by Simplenote iOS and macOS:

### **ResultsController:**
ResultsController powers Simplenote's Notes List:

- Encapsulates NSFetchedResultsController, and exposes a modern Swift API.
- Supports Generics, for your downcasting convenience.
- Heavily Unit Tested
- Batteries included 🔋

We've also implemented convenience **NSTableView** and **UITableView** extensions, capable of keeping such components
in sync with ResultsController events.


### **EntityObserver:**
As implied by its name, EntityObserver allows us to (easily) filter out any CoreData notification of the type
`NSManagedObjectContextObjectsDidChange`, which contains the NSManagedObjectID of the observed entity.

Whenever we do have a match, the delegate will be notified of the new event.
