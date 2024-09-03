//
//  PinsHomeViewModel.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/10/24.
//

import Foundation
import Combine

enum PaginationState {
    case loading
    case idle
    case error(Error)
}

protocol PinsHomeProtocol: AnyObject {
    func fetchPins()
}

class PinsHomeViewModel: ObservableObject, PinsHomeProtocol {
    public static let shared = PinsHomeViewModel()
    let service = PinsNetworkService()
    var pageNo: Int = 1
    @Published var pins: [Pin] = []
    var paginationState: PaginationState = .idle
    var cancellables: Set<AnyCancellable> = []
    
     init() {
        fetchPins()
    }
    
    
    func fetchPins() {
        Task {
        pageNo += 1
         service.fetchPins(pageNo: self.pageNo)
                .receive(on: RunLoop.main)
                .sink { [weak self] completion in
                    switch completion {
                        // hide loader
                    case .failure(let error):
                        // handle error
                        print(error)
                    case .finished:
                        break
                    }
                } receiveValue: { pins in
                    self.pins.append(contentsOf: pins)
                }.store(in: &cancellables)
        }
    }
}
