//
//  MusicViewModel.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import Foundation

// MARK: Request and Handle call back

class MusicViewModel {
    public let api: MusicApiProtocol
    public var MusicFetched: [Artist] = []
    
    var onShowMusic:(() -> Void)?
    
    init(api:MusicApiProtocol) {
        self.api = api
    }
    
   public func fetchMusic(Artist: String) {
        MusicFetched = []
        api.getMusic(Artist: Artist) { [weak self] musics in
            self?.MusicFetched.append(contentsOf: musics)
            self?.onShowMusic?()
        }
    }
    
}

