//
//  ExclusionListService.swift
//  ExclusionListService
//
//  Created by Shun Kashiwa on 2021/08/20.
//

import Foundation
import CoreData
import os

struct ExclusionListService {
    var moc: NSManagedObjectContext

    /// fetchRelevantEntry fetches the relevant entry to the given domain and path
    /// if the domain is excluded, return the domain exclusion entry
    /// if the page is excluded, return the page exclusion entry
    /// neither the domain nor page are excluded, return nil
    public func fetchRelevantEntry(domain: String, path: String) throws -> ExclusionEntryEntity? {
        let fetchRequest: NSFetchRequest<ExclusionEntryEntity> = ExclusionEntryEntity.fetchRequest()
        var predicates = [NSPredicate]()
        predicates.append(NSPredicate(format: "domain == %@", domain))
        // no page entries exist for excluded domains so this is valid
        predicates.append(NSPredicate(format: "path == %@ OR path == nil", path))
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        let entries = try self.moc.fetch(fetchRequest)
        return entries.first
    }

    /// add a new entry to the exclusion list removing all unnecessary entries
    @discardableResult
    public func add(domain: String, path: String?) throws -> ExclusionEntryEntity {
        if path == nil {
            // adding domain entry, remove all existing entries whose domain is the same
            let fetchRequest: NSFetchRequest<ExclusionEntryEntity> = ExclusionEntryEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "domain == %@", domain)
            fetchRequest.includesPropertyValues = false

            // OPTIMIZE: use NSBatchDeleteRequest
            let entries = try self.moc.fetch(fetchRequest)
            for entry in entries {
                self.moc.delete(entry)
            }
        }

        // create new entry
        let entry = ExclusionEntryEntity(context: self.moc)
        entry.id = UUID()
        entry.domain = domain
        entry.path = path

        try self.moc.save()

        return entry
    }

    /// remove an entry from the exclusion list
    public func remove(uuid: String) throws {
        let fetchRequest: NSFetchRequest<ExclusionEntryEntity> = ExclusionEntryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid)
        let entries = try self.moc.fetch(fetchRequest)
        for entry in entries {
            self.moc.delete(entry)
        }
        try self.moc.save()
    }
}
