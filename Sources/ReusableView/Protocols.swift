//
//  Protocols.swift
//  
//
//  Created by marty-suzuki on 2019/12/04.
//

#if os(iOS)
import UIKit

// MARK: - InitializableViewType

public protocol InitializableViewType: UIView {
    init(frame: CGRect)
}

// MARK: - ReusableViewType

public protocol ReusableViewType: UIView {
    static var viewReuseIdentifier: String { get }
    static func make() -> Self
    func prepareForReuse()
}

extension ReusableViewType {

    public static var viewReuseIdentifier: String {
        return String(describing: self)
    }
}

extension ReusableViewType where Self: InitializableViewType {

    public static func make() -> Self {
        return .init(frame: .zero)
    }
}

extension ReusableViewType where Self: NibableViewType {

    public static func make() -> Self {
        return makeFromNib()
    }
}

// MARK: - NibableViewType

public protocol NibableViewType: UIView {
    static var nibName: String { get }
    static var nib: UINib { get }
    static func makeFromNib() -> Self
}

extension NibableViewType {

    public static var nibName: String {
        return String(describing: self)
    }

    public static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    public static func makeFromNib() -> Self {
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
}
#endif
