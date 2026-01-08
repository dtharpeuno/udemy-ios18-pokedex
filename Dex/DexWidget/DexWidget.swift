////
////  DexWidget.swift
////  DexWidget
////
////  Created by dtharpeuno on 1/5/26.
////
//
//import WidgetKit
//import SwiftUI
//import CoreData
//
//@MainActor
//struct Provider: TimelineProvider {
//	var randomPokemon: Pokemon {
//		var results: [Pokemon] = []
//		
//		do {
//			results = try PersistenceController.shared.container.viewContext.fetch(Pokemon.fetchRequest())
//		} catch {
//			print("Couldnt Fetch\(error)")
//		}
//		
//		if let randomPokemon =  results.randomElement() {
//			return randomPokemon
//		}
//		
//		return PersistenceController.previewPokemon
//	}
//	
//	
//	func placeholder(in context: Context) -> SimpleEntry {
//		SimpleEntry.placeholder
//	}
//	
//	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//		let entry = SimpleEntry.placeholder
//		completion(entry)
//	}
//	
//	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//		var entries: [SimpleEntry] = []
//		
//		// Generate a timeline consisting of five entries an hour apart, starting from the current date.
//		let currentDate = Date()
//		for hourOffset in 0 ..< 10 {
//			let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset * 5, to: currentDate)!
//			
//			let entryPokemon = randomPokemon
//			
//			let entry = SimpleEntry(
//				date: entryDate,
//				name: entryPokemon.name,
//				types: entryPokemon.types,
//				sprite: entryPokemon.spriteImage
//			)
//			entries.append(entry)
//		}
//		
//		let timeline = Timeline(entries: entries, policy: .atEnd)
//		completion(timeline)
//	}
//	
//	//    func relevances() async -> WidgetRelevances<Void> {
//	//        // Generate a list containing the contexts this widget is relevant in.
//	//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//	let date: Date
//	let name: String
//	let types: [String]
//	let sprite: Image
//	
//	static var placeholder: SimpleEntry {
//		SimpleEntry(date: .now, name: "bulbasur", types: ["grass", "poison"], sprite: Image(.bulbasaur))
//	}
//	
//	static var placeholderTwo: SimpleEntry {
//		SimpleEntry(date: .now, name: "mew", types: ["psychic"], sprite: Image(.mew))
//	}
//}
//
//struct DexWidgetEntryView : View {
//	@Environment(\.widgetFamily) var widgetSize
//	
//	var entry: Provider.Entry
//	
//	var pokemonImage: some View {
//		entry.sprite
//			.interpolation(.none)
//			.resizable()
//			.scaledToFit()
//			.shadow(color: .black, radius: 6)
//	}
//	
//	var typesView: some View {
//		ForEach(entry.types, id: \.self) {
//			type in
//			Text(type.capitalized)
//				.font(.subheadline)
//				.fontWeight(.semibold)
//				.foregroundStyle(.black)
//				.padding(.horizontal, 13)
//				.padding(.vertical, 5)
//				.background(Color(type.capitalized))
//				.clipShape(.capsule)
//		}
//	}
//	
//	var body: some View {
//		switch widgetSize {
//		case .systemMedium:
//			HStack {
//				pokemonImage
//				Spacer()
//				
//				VStack(alignment: .leading) {
//					Text(entry.name.capitalized)
//						.font(.title)
//						.padding(.vertical, -1)
//					
//					HStack {
//						typesView
//					}
//				}
//				.layoutPriority(1)
//				
//				Spacer()
//			}
//			
//		case .systemLarge:
//			ZStack {
//				pokemonImage
//				
//				VStack(alignment: .leading) {
//					Text(entry.name.capitalized)
//						.font(.largeTitle)
//						.lineLimit(1)
//					
//					Spacer()
//					
//					HStack {
//						Spacer()
//						typesView
//					}
//				}
//			}
//		default:
//			pokemonImage
//		}
//		
//	}
//}
//
//struct DexWidget: Widget {
//	let kind: String = "DexWidget"
//	
//	var body: some WidgetConfiguration {
//		StaticConfiguration(kind: kind, provider: Provider()) { entry in
//			if #available(iOS 17.0, *) {
//				DexWidgetEntryView(entry: entry)
//					.foregroundStyle(.black)
//					.containerBackground(Color(entry.types[0].capitalized), for: .widget)
//			} else {
//				DexWidgetEntryView(entry: entry)
//					.padding()
//					.background()
//			}
//		}
//		.configurationDisplayName("Pokemon")
//		.description("See a random Pokemon.")
//	}
//}
//
//#Preview(as: .systemSmall) {
//	DexWidget()
//} timeline: {
//	SimpleEntry.placeholder
//	SimpleEntry.placeholderTwo
//}
//
//#Preview(as: .systemMedium) {
//	DexWidget()
//} timeline: {
//	SimpleEntry.placeholder
//	SimpleEntry.placeholderTwo
//}
//
//
//#Preview(as: .systemLarge) {
//	DexWidget()
//} timeline: {
//	SimpleEntry.placeholder
//	SimpleEntry.placeholderTwo
//}
//
