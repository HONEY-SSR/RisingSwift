//
//  ScheduleCollectionViewLayout.swift
//  RisingSwift
//
//  Created by SSR on 2022/10/7.
//

import UIKit

protocol ScheduleCollectionViewLayoutDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout: ScheduleCollectionViewLayout, layForItemAt indexPath: IndexPath) -> (week: Int, period: Range<Int>)
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
        var result = [UICollectionViewLayoutAttributes]()
        for section in 0..<sections {
            for elementKind in supplementaryAttributes.keys {
                let indexPath = IndexPath(item: 0, section: section)
                let attribute = self.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
                if attribute!.frame.intersects(rect) {
                    result.append(attribute!)
                }
            }
            let itemCounter = self.collectionView?.dataSource?.collectionView(self.collectionView!, numberOfItemsInSection: section)
            for item in 0..<itemCounter! {
                let indexPath = IndexPath(item: item, section: section)
                let attribute = self.layoutAttributesForItem(at: indexPath)
                if attribute!.frame.intersects(rect) {
                    result.append(attribute!)
                }
            }
        }
        return result
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attribute = supplementaryAttributes[elementKind]![indexPath]
        if attribute != nil {
            return attribute
        }
        attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        supplementaryAttributes[elementKind]![indexPath] = attribute
        if elementKind == UICollectionView.elementKindSectionHeader {
            let x = CGFloat(indexPath.section) * (self.collectionView?.bounds.size.width)!
            let y = self.collectionView?.contentOffset.y
            let frame = CGRect(x: x, y: y!, width: (self.collectionView?.bounds.size.width)!, height: self.heightForHeaderSupplementaryView)
        }
        
        return attribute
    }
    
    func calculateLayoutIfNeeded() {
        if self.collectionView?.dataSource != nil {
            sections = self.collectionView?.dataSource?.numberOfSections?(in: self.collectionView!) ?? 0
        }
    }
}
