//
//  Persistence.swift
//  Dex
//
//  Created by dtharpeuno on 12/31/25.
//

import CoreData

struct PersistenceController {
	// thing that controls the database
	static let shared = PersistenceController()
	
	static var previewPokemon: Pokemon {
		let context = PersistenceController.preview.container.viewContext
		
		let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
		fetchRequest.fetchLimit = 1
		
		let results = try! context.fetch(fetchRequest)
		
		return results.first!
	}
	
	// thing that controls sample preview of database
//	@MainActor
	static let preview: PersistenceController = {
		let result = PersistenceController(inMemory: true)
		let viewContext = result.container.viewContext
		
		let newPokemon = Pokemon(context: viewContext)
		newPokemon.id = 1
		newPokemon.name = "bulbasur"
		newPokemon.types = ["grass", "poison"]
		newPokemon.hp = 45
		newPokemon.attack = 49
		newPokemon.defense =  49
		newPokemon.specialAttack = 65
		newPokemon.specialDefense = 65
		newPokemon.speed = 45
		newPokemon.spriteURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
		newPokemon.shinyURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
		
		do {
			try viewContext.save()
		} catch {
			print(error)
		}
		return result
	}()
	
	// thing that holds the data from the db
	let container: NSPersistentContainer
	
	
	init(inMemory: Bool = false) {
		container = NSPersistentContainer(name: "Dex")
		
		if inMemory {
			container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		} else {
			container.persistentStoreDescriptions.first!.url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.dtharpeuno.DexGroup")!.appending(path: "Dex.sqlite")
		}
		
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				print(error)
			}
		})
		
		container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
		container.viewContext.automaticallyMergesChangesFromParent = true
	}
}
