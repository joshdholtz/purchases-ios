//
//  AttributionKeys.swift
//  PurchasesCoreSwift
//
//  Created by César de la Vega on 6/16/21.
//  Copyright © 2021 Purchases. All rights reserved.
//

import Foundation

internal enum AttributionKeys: String {
    case idfa = "rc_idfa",
         idfv = "rc_idfv",
         ip = "rc_ip_address",
         gpsAdID = "rc_gps_adid",
         networkID = "rc_attribution_network_id"

    internal enum Adjust: String {
        case id = "adid",
             network = "network",
             campaign = "campaign",
             adGroup = "adgroup",
             creative = "creative"
    }

    internal enum AppsFlyer: String {
        case id = "rc_appsflyer_id",
             campaign = "campaign",
             channel = "af_channel",
             mediaSource = "media_source",
             adSet = "adset",
             ad = "af_ad",
             adGroup = "adgroup",
             adKeywords = "af_keywords",
             adID = "ad_id",
             dataKey = "data",
             statusKey = "status"
    }

    internal enum Branch: String {
        case campaign = "campaign",
             channel = "channel"
    }

    internal enum MParticle: String {
        case id = "mpid"
    }
}
