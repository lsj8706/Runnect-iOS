//
//  RNMarker.swift
//  Runnect-iOS
//
//  Created by sejin on 2023/01/02.
//

import UIKit

import NMapsMap

final class RNMarker: NMFMarker {
    
    // MARK: - initialization
    
    override init() {
        super.init()
        setUI()
    }
}

// MARK: - UI & Layout

extension RNMarker {
    private func setUI() {
        let image = NMFOverlayImage(image: ImageLiterals.icMapPoint) // 비트맵 공유를 통한 메모리 관리
        self.iconImage = image
        
        self.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        self.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        
        self.anchor = CGPoint(x: 0.5, y: 0.5)
        
        self.iconPerspectiveEnabled = true
    }
}
