//
//  Typealiases.swift
//  
//
//  Created by marty-suzuki on 2019/12/04.
//

#if os(iOS)
import UIKit

public typealias ReusableView = UIView & ReusableViewType & InitializableViewType
public typealias ReusableNibView = UIView & ReusableViewType & NibableViewType
#endif
