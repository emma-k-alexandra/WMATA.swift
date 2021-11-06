//
//  Station+OpeningTimes.swift
//  
//
//  Created by Emma on 11/6/21.
//

import Foundation

extension Station {
    internal static var openingTimes: [Station: [WeekdaySaturdayOrSunday: DateComponents]] = [
        .A01: [
            .sunday: DateComponents(hour: 8, minute: 14),
            .weekday: DateComponents(hour: 5, minute: 14),
            .saturday: DateComponents(hour: 7, minute: 14),
        ],
        .A02: [
            .sunday: DateComponents(hour: 8, minute: 24),
            .weekday: DateComponents(hour: 5, minute: 24),
            .saturday: DateComponents(hour: 7, minute: 24),
        ],
        .A03: [
            .sunday: DateComponents(hour: 8, minute: 23),
            .weekday: DateComponents(hour: 5, minute: 23),
            .saturday: DateComponents(hour: 7, minute: 23),
        ],
        .A04: [
            .sunday: DateComponents(hour: 8, minute: 21),
            .weekday: DateComponents(hour: 5, minute: 21),
            .saturday: DateComponents(hour: 7, minute: 21),
        ],
        .A05: [
            .sunday: DateComponents(hour: 8, minute: 19),
            .weekday: DateComponents(hour: 5, minute: 19),
            .saturday: DateComponents(hour: 7, minute: 19),
        ],
        .A06: [
            .sunday: DateComponents(hour: 8, minute: 17),
            .weekday: DateComponents(hour: 5, minute: 17),
            .saturday: DateComponents(hour: 7, minute: 17),
        ],
        .A07: [
            .sunday: DateComponents(hour: 8, minute: 14),
            .weekday: DateComponents(hour: 5, minute: 14),
            .saturday: DateComponents(hour: 7, minute: 14),
        ],
        .A08: [
            .sunday: DateComponents(hour: 8, minute: 12),
            .weekday: DateComponents(hour: 5, minute: 12),
            .saturday: DateComponents(hour: 7, minute: 12),
        ],
        .A09: [
            .sunday: DateComponents(hour: 8, minute: 9),
            .weekday: DateComponents(hour: 5, minute: 9),
            .saturday: DateComponents(hour: 7, minute: 9),
        ],
        .A10: [
            .sunday: DateComponents(hour: 8, minute: 6),
            .weekday: DateComponents(hour: 5, minute: 6),
            .saturday: DateComponents(hour: 7, minute: 6),
        ],
        .A11: [
            .sunday: DateComponents(hour: 8, minute: 3),
            .weekday: DateComponents(hour: 5, minute: 3),
            .saturday: DateComponents(hour: 7, minute: 3),
        ],
        .A12: [
            .sunday: DateComponents(hour: 8, minute: 0),
            .weekday: DateComponents(hour: 5, minute: 0),
            .saturday: DateComponents(hour: 7, minute: 0),
        ],
        .A13: [
            .sunday: DateComponents(hour: 7, minute: 57),
            .weekday: DateComponents(hour: 4, minute: 57),
            .saturday: DateComponents(hour: 6, minute: 57),
        ],
        .A14: [
            .sunday: DateComponents(hour: 7, minute: 54),
            .weekday: DateComponents(hour: 4, minute: 54),
            .saturday: DateComponents(hour: 6, minute: 54),
        ],
        .A15: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .B01: [
            .sunday: DateComponents(hour: 8, minute: 15),
            .weekday: DateComponents(hour: 5, minute: 15),
            .saturday: DateComponents(hour: 7, minute: 15),
        ],
        .B02: [
            .sunday: DateComponents(hour: 8, minute: 17),
            .weekday: DateComponents(hour: 5, minute: 17),
            .saturday: DateComponents(hour: 7, minute: 17),
        ],
        .B03: [
            .sunday: DateComponents(hour: 8, minute: 15),
            .weekday: DateComponents(hour: 5, minute: 15),
            .saturday: DateComponents(hour: 7, minute: 15),
        ],
        .B04: [
            .sunday: DateComponents(hour: 8, minute: 11),
            .weekday: DateComponents(hour: 5, minute: 11),
            .saturday: DateComponents(hour: 7, minute: 11),
        ],
        .B05: [
            .sunday: DateComponents(hour: 8, minute: 8),
            .weekday: DateComponents(hour: 5, minute: 8),
            .saturday: DateComponents(hour: 7, minute: 8),
        ],
        .B06: [
            .sunday: DateComponents(hour: 8, minute: 0),
            .weekday: DateComponents(hour: 5, minute: 0),
            .saturday: DateComponents(hour: 7, minute: 0),
        ],
        .B07: [
            .sunday: DateComponents(hour: 8, minute: 2),
            .weekday: DateComponents(hour: 5, minute: 2),
            .saturday: DateComponents(hour: 7, minute: 2),
        ],
        .B08: [
            .sunday: DateComponents(hour: 7, minute: 59),
            .weekday: DateComponents(hour: 4, minute: 59),
            .saturday: DateComponents(hour: 6, minute: 59),
        ],
        .B09: [
            .sunday: DateComponents(hour: 7, minute: 56),
            .weekday: DateComponents(hour: 4, minute: 56),
            .saturday: DateComponents(hour: 6, minute: 56),
        ],
        .B10: [
            .sunday: DateComponents(hour: 7, minute: 53),
            .weekday: DateComponents(hour: 4, minute: 53),
            .saturday: DateComponents(hour: 6, minute: 53),
        ],
        .B11: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .B35: [
            .sunday: DateComponents(hour: 8, minute: 13),
            .weekday: DateComponents(hour: 5, minute: 13),
            .saturday: DateComponents(hour: 7, minute: 13),
        ],
        .C01: [
            .sunday: DateComponents(hour: 8, minute: 14),
            .weekday: DateComponents(hour: 5, minute: 14),
            .saturday: DateComponents(hour: 7, minute: 14),
        ],
        .C02: [
            .sunday: DateComponents(hour: 8, minute: 16),
            .weekday: DateComponents(hour: 5, minute: 16),
            .saturday: DateComponents(hour: 7, minute: 16),
        ],
        .C03: [
            .sunday: DateComponents(hour: 8, minute: 18),
            .weekday: DateComponents(hour: 5, minute: 18),
            .saturday: DateComponents(hour: 7, minute: 18),
        ],
        .C04: [
            .sunday: DateComponents(hour: 8, minute: 16),
            .weekday: DateComponents(hour: 5, minute: 16),
            .saturday: DateComponents(hour: 7, minute: 16),
        ],
        .C05: [
            .sunday: DateComponents(hour: 8, minute: 17),
            .weekday: DateComponents(hour: 5, minute: 17),
            .saturday: DateComponents(hour: 7, minute: 17),
        ],
        .C06: [
            .sunday: DateComponents(hour: 8, minute: 17),
            .weekday: DateComponents(hour: 5, minute: 17),
            .saturday: DateComponents(hour: 7, minute: 17),
        ],
        .C07: [
            .sunday: DateComponents(hour: 8, minute: 7),
            .weekday: DateComponents(hour: 5, minute: 7),
            .saturday: DateComponents(hour: 7, minute: 7),
        ],
        .C08: [
            .sunday: DateComponents(hour: 8, minute: 5),
            .weekday: DateComponents(hour: 5, minute: 5),
            .saturday: DateComponents(hour: 7, minute: 5),
        ],
        .C09: [
            .sunday: DateComponents(hour: 8, minute: 3),
            .weekday: DateComponents(hour: 5, minute: 3),
            .saturday: DateComponents(hour: 7, minute: 3),
        ],
        .C10: [
            .sunday: DateComponents(hour: 8, minute: 1),
            .weekday: DateComponents(hour: 5, minute: 1),
            .saturday: DateComponents(hour: 7, minute: 1),
        ],
        .C12: [
            .sunday: DateComponents(hour: 7, minute: 56),
            .weekday: DateComponents(hour: 4, minute: 56),
            .saturday: DateComponents(hour: 6, minute: 56),
        ],
        .C13: [
            .sunday: DateComponents(hour: 7, minute: 54),
            .weekday: DateComponents(hour: 4, minute: 54),
            .saturday: DateComponents(hour: 6, minute: 54),
        ],
        .C14: [
            .sunday: DateComponents(hour: 7, minute: 52),
            .weekday: DateComponents(hour: 4, minute: 52),
            .saturday: DateComponents(hour: 6, minute: 52),
        ],
        .C15: [
            .sunday: DateComponents(hour: 8, minute: 50),
            .weekday: DateComponents(hour: 5, minute: 50),
            .saturday: DateComponents(hour: 7, minute: 50),
        ],
        .D01: [
            .sunday: DateComponents(hour: 8, minute: 13),
            .weekday: DateComponents(hour: 5, minute: 13),
            .saturday: DateComponents(hour: 7, minute: 13),
        ],
        .D02: [
            .sunday: DateComponents(hour: 8, minute: 11),
            .weekday: DateComponents(hour: 5, minute: 11),
            .saturday: DateComponents(hour: 7, minute: 11),
        ],
        .D03: [
            .sunday: DateComponents(hour: 8, minute: 9),
            .weekday: DateComponents(hour: 5, minute: 9),
            .saturday: DateComponents(hour: 7, minute: 9),
        ],
        .D04: [
            .sunday: DateComponents(hour: 8, minute: 7),
            .weekday: DateComponents(hour: 5, minute: 7),
            .saturday: DateComponents(hour: 7, minute: 7),
        ],
        .D05: [
            .sunday: DateComponents(hour: 8, minute: 5),
            .weekday: DateComponents(hour: 5, minute: 5),
            .saturday: DateComponents(hour: 7, minute: 5),
        ],
        .D06: [
            .sunday: DateComponents(hour: 8, minute: 3),
            .weekday: DateComponents(hour: 5, minute: 3),
            .saturday: DateComponents(hour: 7, minute: 3),
        ],
        .D07: [
            .sunday: DateComponents(hour: 8, minute: 1),
            .weekday: DateComponents(hour: 5, minute: 1),
            .saturday: DateComponents(hour: 7, minute: 1),
        ],
        .D08: [
            .sunday: DateComponents(hour: 7, minute: 59),
            .weekday: DateComponents(hour: 4, minute: 59),
            .saturday: DateComponents(hour: 6, minute: 59),
        ],
        .D09: [
            .sunday: DateComponents(hour: 8, minute: 0),
            .weekday: DateComponents(hour: 5, minute: 0),
            .saturday: DateComponents(hour: 7, minute: 0),
        ],
        .D10: [
            .sunday: DateComponents(hour: 7, minute: 58),
            .weekday: DateComponents(hour: 4, minute: 58),
            .saturday: DateComponents(hour: 6, minute: 58),
        ],
        .D11: [
            .sunday: DateComponents(hour: 7, minute: 56),
            .weekday: DateComponents(hour: 4, minute: 56),
            .saturday: DateComponents(hour: 6, minute: 56),
        ],
        .D12: [
            .sunday: DateComponents(hour: 7, minute: 53),
            .weekday: DateComponents(hour: 4, minute: 53),
            .saturday: DateComponents(hour: 6, minute: 53),
        ],
        .D13: [
            .sunday: DateComponents(hour: 7, minute: 59),
            .weekday: DateComponents(hour: 4, minute: 59),
            .saturday: DateComponents(hour: 6, minute: 59),
        ],
        .E01: [
            .sunday: DateComponents(hour: 8, minute: 14),
            .weekday: DateComponents(hour: 5, minute: 14),
            .saturday: DateComponents(hour: 7, minute: 14),
        ],
        .E02: [
            .sunday: DateComponents(hour: 8, minute: 13),
            .weekday: DateComponents(hour: 5, minute: 13),
            .saturday: DateComponents(hour: 7, minute: 13),
        ],
        .E03: [
            .sunday: DateComponents(hour: 8, minute: 11),
            .weekday: DateComponents(hour: 5, minute: 11),
            .saturday: DateComponents(hour: 7, minute: 11),
        ],
        .E04: [
            .sunday: DateComponents(hour: 8, minute: 9),
            .weekday: DateComponents(hour: 5, minute: 9),
            .saturday: DateComponents(hour: 7, minute: 9),
        ],
        .E05: [
            .sunday: DateComponents(hour: 8, minute: 6),
            .weekday: DateComponents(hour: 5, minute: 6),
            .saturday: DateComponents(hour: 7, minute: 6),
        ],
        .E06: [
            .sunday: DateComponents(hour: 8, minute: 0),
            .weekday: DateComponents(hour: 5, minute: 0),
            .saturday: DateComponents(hour: 7, minute: 0),
        ],
        .E07: [
            .sunday: DateComponents(hour: 7, minute: 59),
            .weekday: DateComponents(hour: 4, minute: 59),
            .saturday: DateComponents(hour: 6, minute: 59),
        ],
        .E08: [
            .sunday: DateComponents(hour: 7, minute: 56),
            .weekday: DateComponents(hour: 4, minute: 56),
            .saturday: DateComponents(hour: 6, minute: 56),
        ],
        .E09: [
            .sunday: DateComponents(hour: 7, minute: 53),
            .weekday: DateComponents(hour: 4, minute: 53),
            .saturday: DateComponents(hour: 6, minute: 53),
        ],
        .E10: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .F01: [
            .sunday: DateComponents(hour: 8, minute: 15),
            .weekday: DateComponents(hour: 5, minute: 15),
            .saturday: DateComponents(hour: 7, minute: 15),
        ],
        .F02: [
            .sunday: DateComponents(hour: 8, minute: 13),
            .weekday: DateComponents(hour: 5, minute: 13),
            .saturday: DateComponents(hour: 7, minute: 13),
        ],
        .F03: [
            .sunday: DateComponents(hour: 8, minute: 9),
            .weekday: DateComponents(hour: 5, minute: 9),
            .saturday: DateComponents(hour: 7, minute: 9),
        ],
        .F04: [
            .sunday: DateComponents(hour: 8, minute: 9),
            .weekday: DateComponents(hour: 5, minute: 9),
            .saturday: DateComponents(hour: 7, minute: 9),
        ],
        .F05: [
            .sunday: DateComponents(hour: 8, minute: 7),
            .weekday: DateComponents(hour: 5, minute: 7),
            .saturday: DateComponents(hour: 7, minute: 7),
        ],
        .F06: [
            .sunday: DateComponents(hour: 8, minute: 4),
            .weekday: DateComponents(hour: 5, minute: 4),
            .saturday: DateComponents(hour: 7, minute: 4),
        ],
        .F07: [
            .sunday: DateComponents(hour: 8, minute: 1),
            .weekday: DateComponents(hour: 5, minute: 1),
            .saturday: DateComponents(hour: 7, minute: 1),
        ],
        .F08: [
            .sunday: DateComponents(hour: 7, minute: 59),
            .weekday: DateComponents(hour: 4, minute: 59),
            .saturday: DateComponents(hour: 6, minute: 59),
        ],
        .F09: [
            .sunday: DateComponents(hour: 7, minute: 56),
            .weekday: DateComponents(hour: 4, minute: 56),
            .saturday: DateComponents(hour: 6, minute: 56),
        ],
        .F10: [
            .sunday: DateComponents(hour: 7, minute: 53),
            .weekday: DateComponents(hour: 4, minute: 53),
            .saturday: DateComponents(hour: 6, minute: 53),
        ],
        .F11: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .G01: [
            .sunday: DateComponents(hour: 7, minute: 55),
            .weekday: DateComponents(hour: 4, minute: 55),
            .saturday: DateComponents(hour: 6, minute: 55),
        ],
        .G02: [
            .sunday: DateComponents(hour: 7, minute: 52),
            .weekday: DateComponents(hour: 4, minute: 52),
            .saturday: DateComponents(hour: 6, minute: 52),
        ],
        .G03: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .G04: [
            .sunday: DateComponents(hour: 7, minute: 47),
            .weekday: DateComponents(hour: 4, minute: 47),
            .saturday: DateComponents(hour: 6, minute: 47),
        ],
        .G05: [
            .sunday: DateComponents(hour: 7, minute: 44),
            .weekday: DateComponents(hour: 4, minute: 44),
            .saturday: DateComponents(hour: 6, minute: 44),
        ],
        .J02: [
            .sunday: DateComponents(hour: 7, minute: 56),
            .weekday: DateComponents(hour: 4, minute: 56),
            .saturday: DateComponents(hour: 6, minute: 56),
        ],
        .J03: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .K01: [
            .sunday: DateComponents(hour: 8, minute: 10),
            .weekday: DateComponents(hour: 5, minute: 10),
            .saturday: DateComponents(hour: 7, minute: 10),
        ],
        .K02: [
            .sunday: DateComponents(hour: 8, minute: 8),
            .weekday: DateComponents(hour: 5, minute: 8),
            .saturday: DateComponents(hour: 7, minute: 8),
        ],
        .K03: [
            .sunday: DateComponents(hour: 8, minute: 7),
            .weekday: DateComponents(hour: 5, minute: 7),
            .saturday: DateComponents(hour: 7, minute: 7),
        ],
        .K04: [
            .sunday: DateComponents(hour: 8, minute: 9),
            .weekday: DateComponents(hour: 5, minute: 9),
            .saturday: DateComponents(hour: 7, minute: 9),
        ],
        .K05: [
            .sunday: DateComponents(hour: 8, minute: 1),
            .weekday: DateComponents(hour: 5, minute: 1),
            .saturday: DateComponents(hour: 7, minute: 1),
        ],
        .K06: [
            .sunday: DateComponents(hour: 7, minute: 58),
            .weekday: DateComponents(hour: 4, minute: 58),
            .saturday: DateComponents(hour: 6, minute: 58),
        ],
        .K07: [
            .sunday: DateComponents(hour: 7, minute: 54),
            .weekday: DateComponents(hour: 4, minute: 54),
            .saturday: DateComponents(hour: 6, minute: 54),
        ],
        .K08: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
        .N01: [
            .sunday: DateComponents(hour: 8, minute: 3),
            .weekday: DateComponents(hour: 5, minute: 3),
            .saturday: DateComponents(hour: 7, minute: 3),
        ],
        .N02: [
            .sunday: DateComponents(hour: 8, minute: 1),
            .weekday: DateComponents(hour: 5, minute: 1),
            .saturday: DateComponents(hour: 7, minute: 1),
        ],
        .N03: [
            .sunday: DateComponents(hour: 7, minute: 59),
            .weekday: DateComponents(hour: 4, minute: 59),
            .saturday: DateComponents(hour: 6, minute: 59),
        ],
        .N04: [
            .sunday: DateComponents(hour: 7, minute: 57),
            .weekday: DateComponents(hour: 4, minute: 57),
            .saturday: DateComponents(hour: 6, minute: 57),
        ],
        .N06: [
            .sunday: DateComponents(hour: 7, minute: 50),
            .weekday: DateComponents(hour: 4, minute: 50),
            .saturday: DateComponents(hour: 6, minute: 50),
        ],
    ]
}
