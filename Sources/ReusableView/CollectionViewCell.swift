//
//  CollectionViewCell.swift
//  
//
//  Created by marty-suzuki on 2019/12/04.
//

#if os(iOS)
import UIKit

public final class CollectionViewCell<View: ReusableViewType>: UICollectionViewCell {

    public let view = View.make()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        view.frame = contentView.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(view)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        view.frame = contentView.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(view)
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        view.prepareForReuse()
    }
}
#endif
