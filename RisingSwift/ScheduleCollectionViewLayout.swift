//
//  ScheduleCollectionViewLayout.swift
//  RisingSwift
//
//  Created by SSR on 2022/10/7.
//

import UIKit

protocol ScheduleCollectionViewLayoutDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, layForItemAt indexPath: IndexPath) -> (Int, Range<Int>)
}

class ScheduleCollectionViewLayout: UICollectionViewLayout {
    class ScheduleCollectionViewLayoutInvalidationContext: UICollectionViewLayoutInvalidationContext {
        var invalidateHeaderSupplementaryAttributes: Bool = false
        var invalidateLeadingSupplementaryAttributes: Bool = false
        var invalidateAllAttributes: Bool = false
    }
    
    var lineSpacing: CGFloat
    var columnSpacing: CGFloat
    var widthForLeadingSupplementaryView: CGFloat
    var heightForHeaderSupplementaryView: CGFloat
    
    private var sections: Int = 0
    private var itemSize: CGSize = CGSizeZero
    private var itemAttributes: Dictionary<IndexPath, UICollectionViewLayoutAttributes> = [:]
    private var supplementaryAttributes: Dictionary<String, Dictionary<IndexPath, UICollectionViewLayoutAttributes>> = [
        UICollectionView.elementKindSectionHeader:[:],
        UICollectionView.elementKindSectionLeading:[:],
    ]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(lineSpacing: CGFloat, columnSpacing: CGFloat, widthForLeadingSupplementaryView: CGFloat, heightForHeaderSupplementaryView: CGFloat) {
        self.lineSpacing = lineSpacing
        self.columnSpacing = columnSpacing
        self.widthForLeadingSupplementaryView = widthForLeadingSupplementaryView
        self.heightForHeaderSupplementaryView = heightForHeaderSupplementaryView
        
        super.init()
        let width = ((self.collectionView?.bounds.size.width)! - self.widthForLeadingSupplementaryView) / 7 - self.columnSpacing
        itemSize = CGSizeMake(width, width / 46 * 50)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let result = [UICollectionViewLayoutAttributes]()
        for section in 0..<sections {
            for elementKind in supplementaryAttributes.keys {
                
            }
        }
        return result
    }
    
    func calculateLayoutIfNeeded() {
        if self.collectionView?.dataSource != nil {
            sections = self.collectionView?.dataSource?.numberOfSections?(in: self.collectionView!) ?? 0
        }
    }
}
