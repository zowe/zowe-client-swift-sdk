//
//  DatasetTypes.swift
//  Zowe SDK
//
//  This program and the accompanying materials are made available under the terms of the
//  Eclipse Public License v2.0 which accompanies this distribution, and is available at
//  https://www.eclipse.org/legal/epl-v20.html
//  SPDX-License-Identifier: EPL-2.0
//
//  Copyright © 2020 Contributors to the Zowe Project. All rights reserved.
//

import Foundation

/// Enumerated type that describes the different kinds of data sets that can be created
public enum DatasetTypes {
    case partitioned, sequential
    
    /// Specifies all the default attributes to create non-vsam data sets: partitioned and sequential ones
    /// - Returns: Default attributes to be used as options for the different types of data sets that can be created
    internal func defaultAttributes() -> [String: Any] {
        switch self {
        case .partitioned:
            return [
                "dsorg": "PO",
                "alcunit": "CYL",
                "primary": 1,
                "secondary": 1,
                "dirblk": 5,
                "recfm": "FB",
                "blksize": 6160,
                "lrecl": 80
            ]
        case .sequential:
            return [
                "dsorg": "PS",
                "alcunit": "CYL",
                "primary": 1,
                "secondary": 1,
                "recfm": "FB",
                "blksize": 6160,
                "lrecl": 80
            ]
        }
    }
}
