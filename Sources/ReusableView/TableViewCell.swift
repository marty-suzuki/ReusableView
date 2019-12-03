//
//  TableViewCell.swift
//  
//
//  Created by marty-suzuki on 2019/12/04.
//

#if os(iOS)
import UIKit

public final class TableViewCell<View: ReusableViewType>: UITableViewCell {

    public let view = View.make()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
