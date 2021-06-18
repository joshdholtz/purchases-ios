//
//  AttributionDataMigrator.swift
//  PurchasesCoreSwift
//
//  Created by César de la Vega on 6/16/21.
//  Copyright © 2021 Purchases. All rights reserved.
//

import Foundation

internal class AttributionDataMigrator: NSObject {

    func convertAttributionDataToSubscriberAttributes(
            attributionData: [String: Any?], network: AttributionNetwork
    ) -> [String: Any?] {
        var convertedAttribution: [String: Any?] = [:]
        for (key, value) in attributionData {
            if key == AttributionKeys.idfa.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.idfa] = value
            } else if key == AttributionKeys.idfv.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.idfv] = value
            } else if key == AttributionKeys.ip.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.ip] = value
            } else if key == AttributionKeys.gpsAdID.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.gpsAdId] = value
            }
        }
        let networkSpecificSubscriberAttributes: [String: Any?]
        switch network {
        case .RCAttributionNetworkAppleSearchAds:
            networkSpecificSubscriberAttributes = convertAppleSearchAdsAttribution(attributionData)
        case .RCAttributionNetworkAdjust:
            networkSpecificSubscriberAttributes = convertAdjustAttribution(attributionData)
        case .RCAttributionNetworkAppsFlyer:
            networkSpecificSubscriberAttributes = convertAppsFlyerAttribution(attributionData)
        case .RCAttributionNetworkBranch:
            networkSpecificSubscriberAttributes = convertBranchAttribution(attributionData)
        case .RCAttributionNetworkTenjin,
             .RCAttributionNetworkFacebook:
            networkSpecificSubscriberAttributes = [:]
        case .RCAttributionNetworkMParticle:
            networkSpecificSubscriberAttributes = convertMParticleAttribution(attributionData)
        }
        return convertedAttribution.merging(networkSpecificSubscriberAttributes) { (_, new) -> Any? in
            new
        }
    }

    private func convertMParticleAttribution(_ data: [String: Any?]) -> [String: Any?] {
        var convertedAttribution: [String: Any?] = [:]
        for (key, value) in data {
            if key == AttributionKeys.MParticle.id.rawValue || key == AttributionKeys.networkID.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.mpParticleID] = value
            }
        }
        return convertedAttribution
    }

    private func convertBranchAttribution(_ data: [String: Any?]) -> [String: Any?] {
        var convertedAttribution: [String: Any?] = [:]
        for (key, value) in data {
            if key == AttributionKeys.Branch.channel.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.mediaSource] = value
            } else if key == AttributionKeys.Branch.campaign.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.campaign] = value
            }
        }
        return convertedAttribution
    }

    private func convertAppsFlyerAttribution(_ data: [String: Any?]) -> [String: Any?] {
        var fixedData = data
        if let innerDataObject = fixedData[AttributionKeys.AppsFlyer.dataKey.rawValue] as? [String: Any?] {
            if fixedData[AttributionKeys.AppsFlyer.statusKey.rawValue] != nil {
                for (key, value) in innerDataObject {
                    fixedData[key] = value
                }
            }
        }

        var convertedAttribution: [String: Any?] = [:]
        for (key, value) in fixedData {
            if key == AttributionKeys.AppsFlyer.id.rawValue || key == AttributionKeys.networkID.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.appsFlyerID] = value
            } else if key == AttributionKeys.AppsFlyer.channel.rawValue ||
                              key == AttributionKeys.AppsFlyer.mediaSource.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.mediaSource] = value
            } else if key == AttributionKeys.AppsFlyer.campaign.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.campaign] = value
            } else if key == AttributionKeys.AppsFlyer.adSet.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.adGroup] = value
            } else if key == AttributionKeys.AppsFlyer.ad.rawValue ||
                              key == AttributionKeys.AppsFlyer.adGroup.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.ad] = value
            } else if key == AttributionKeys.AppsFlyer.adKeywords.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.keyword] = value
            } else if key == AttributionKeys.AppsFlyer.adID.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.creative] = value
            }
        }
        return convertedAttribution
    }

    private func convertAdjustAttribution(_ data: [String: Any?]) -> [String: Any?] {
        var convertedAttribution: [String: Any?] = [:]
        for (key, value) in data {
            if key == AttributionKeys.Adjust.id.rawValue || key == AttributionKeys.networkID.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.adjustID] = value
            } else if key == AttributionKeys.Adjust.network.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.mediaSource] = value
            } else if key == AttributionKeys.Adjust.campaign.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.campaign] = value
            } else if key == AttributionKeys.Adjust.adGroup.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.adGroup] = value
            } else if key == AttributionKeys.Adjust.creative.rawValue {
                convertedAttribution[SpecialSubscriberAttributes.creative] = value
            }
        }
        return convertedAttribution
    }

    private func convertAppleSearchAdsAttribution(_ data: [String: Any?]) -> [String: Any?] {
        return [:]
    }
}
