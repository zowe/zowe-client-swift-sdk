//
//  ZOSDatasetTypes.swift
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
public enum ZOSDatasetTypes {
    case binary, c, classic, partitioned, sequential
    
    /// Specifies all the default attributes to create non-vsam data sets: binary, C, classic, partitioned and sequential ones
    /// - Returns: Default attributes to be used as options for the different types of data sets that can be created
    /// - Note: Technically, binary, C and classic data sets are all partitioned data sets. They just have different default attributes.
    internal func defaultAttributes() -> [String: Any] {
        switch self {
        case .binary:
            return [
                "dsorg": "PO",
                "alcunit": "CYL",
                "primary": 10,
                "secondary": 10,
                "dirblk": 25,
                "recfm": "U",
                "blksize": 27998,
                "lrecl": 27998
            ]
        case .c:
            return [
                "dsorg": "PO",
                "alcunit": "CYL",
                "primary": 1,
                "secondary": 1,
                "dirblk": 25,
                "recfm": "VB",
                "blksize": 32760,
                "lrecl": 260
            ]
        case .classic:
            return [
                "dsorg": "PO",
                "alcunit": "CYL",
                "primary": 1,
                "secondary": 1,
                "dirblk": 25,
                "recfm": "FB",
                "blksize": 6160,
                "lrecl": 80
            ]
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
