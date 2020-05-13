//
//  ReusableViewExtension.swift
//  
//
//  Created by marty-suzuki on 2019/12/04.
//

#if os(iOS)
import UIKit

// MARK: - ReusableViewExtension

public struct ReusableViewExtension<T> {
    fileprivate let base: T
}

// MARK: - UICollectionView

extension ReusableViewExtension where T: UICollectionView {

    public func register<View: ReusableViewType>(_: View.Type) {
        let identifier = View.viewReuseIdentifier
        base.register(CollectionViewCell<View>.self, forCellWithReuseIdentifier: identifier)
    }

    public func dequeue<View: ReusableViewType>(_: View.Type, for indexPath: IndexPath, handler: ((View) -> Void)? = nil) -> CollectionViewCell<View> {
        let identifier = View.viewReuseIdentifier
        let cell = base.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CollectionViewCell<View>
        handler?(cell.view)
        return cell
    }

    public func cell<View: ReusableViewType>(_: View.Type, forItemAt indexPath: IndexPath) -> CollectionViewCell<View>? {
        return base.cellForItem(at: indexPath) as? CollectionViewCell<View>
    }
}

extension UICollectionView {

    public var rv: ReusableViewExtension<UICollectionView> {
        return .init(base: self)
    }
}

// MARK: - UITableView

extension ReusableViewExtension where T: UITableView {

    public func register<View: ReusableViewType>(_: View.Type) {
        let identifier = View.viewReuseIdentifier
        base.register(TableViewCell<View>.self, forCellReuseIdentifier: identifier)
    }

    public func dequeue<View: ReusableViewType>(_: View.Type, for indexPath: IndexPath, handler: ((View) -> Void)? = nil) -> TableViewCell<View> {
        let identifier = View.viewReuseIdentifier
        let cell = base.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TableViewCell<View>
        handler?(cell.view)
        return cell
    }

    public func cell<View: ReusableViewType>(_: View.Type, forRowAt indexPath: IndexPath) -> TableViewCell<View>? {
        return base.cellForRow(at: indexPath) as? TableViewCell<View>
    }
}

extension UITableView {

    public var rv: ReusableViewExtension<UITableView> {
        return .init(base: self)
    }
}
#endif
