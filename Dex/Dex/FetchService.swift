//
//  FetchService.swift
//  Dex
//
//  Created by dtharpeuno on 1/3/26.
//


import Foundation


struct FetchService {
	enum FetchError: Error {
		case badResponse
	}
	
	private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	
	func fetchPokemon(_ id: Int) async throws -> FetchedPokemon {
		let fetchURL = baseURL.appending(path: String(id))
		
		let (data, response) = try await URLSession.shared.data(from: fetchURL)
		
		guard let response =  response as? HTTPURLResponse, response.statusCode == 200 else {
			throw FetchError.badResponse
		}
		
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		let pokemon = try decoder.decode(FetchedPokemon.self, from: data)
				
		return pokemon
	}
}
