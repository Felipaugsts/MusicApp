//
//  MusicContainer.swift
//  MusicApp
//
//  Created by FELIPE AUGUSTO SILVA on 09/02/22.
//

import Foundation
import Swinject

class AppContainer {
    public static let shared: Container = {
        let container = Container()
        
        container.register(MusicApiProtocol.self) { _ in ItunesApi()}
        
        container.register(MusicViewModel.self) { r in MusicViewModel(api: r.resolve(MusicApiProtocol.self)!)
        }
        
        container.register(favoriteProtocol.self) { _ in FavoriteCore() }
        
        container.register(FavoriteViewModel.self) { r in FavoriteViewModel(core: r.resolve(favoriteProtocol.self)!)
            
        }
        return container
    }()
    
}
