import XCTest
import Nimble
import StoreKit

@testable import PurchasesCoreSwift

class AttributionDataMigratorTests: XCTestCase {

    static var defaultIdfa = "00000000-0000-0000-0000-000000000000"
    static var defaultIdfv = "A9CFE78C-51F8-4808-94FD-56B4535753C6"
    static var defaultIp = "192.168.1.130"

    var attributionDataMigrator: AttributionDataMigrator!

    override func setUp() {
        super.setUp()
        attributionDataMigrator = AttributionDataMigrator()
    }

    func testAdjustAttributionIsConverted() {
        let adjustData = adjustData()
    }

    private func adjustData(with idfa: String? = defaultIdfa,
                            addAdId: Bool = true,
                            addNetworkID: Bool = false,
                            idfv: String? = defaultIdfv) -> [String: Any?] {
        var adjustData: [String: Any?] = [
            "clickLabel": "clickey",
            "trackerToken": "6abc940",
            "trackerName": "Instagram Profile::IG Spanish",
            "\(AttributionKeys.Adjust.campaign)": "IG Spanish",
            "\(AttributionKeys.Adjust.adGroup)": "an_ad_group",
            "\(AttributionKeys.Adjust.creative)": "a_creative",
            "\(AttributionKeys.Adjust.network)": "Instagram Profile",
            "\(AttributionKeys.ip)": AttributionDataMigratorTests.defaultIp,
            "\(AttributionKeys.idfa)": idfa,
            "\(AttributionKeys.idfv)": idfv
        ]
        if addAdId {
            adjustData[AttributionKeys.Adjust.id.rawValue] = "20f0c0000aca0b00000fb0000c0f0f00"
        }
        if addNetworkID {
            adjustData[AttributionKeys.networkID.rawValue] = "10f0c0000aca0b00000fb0000c0f0f00"
        }
        return adjustData
    }

    private func appsFlyerData(with idfa: String? = defaultIdfa,
                               addAppsFlyerId: Bool = true,
                               addNetworkID: Bool = false,
                               idfv: String? = defaultIdfv,
                               addChannel: Bool = true,
                               addMediaSource: Bool = false,
                               addAd: Bool = true,
                               addAdGroup: Bool = false) -> [String: Any?] {
        var appsFlyerData: [String: Any?] = [
            "adset_id": "23847301359550211",
            "campaign_id": "23847301359200211",
            "click_time": "2021-05-04 18:08:51.000",
            "iscache": false,
            "adset": "0111 - mm - aaa - US - best 10",
            "adgroup_id": "238473013556789090",
            "is_mobile_data_terms_signed": true,
            "match_type": "srn",
            "agency": nil,
            "retargeting_conversion_type": "none",
            "install_time": "2021-05-04 18:20:45.050",
            "af_status": "Non-organic",
            "http_referrer": nil,
            "is_paid": true,
            "is_first_launch": false,
            "is_fb": true,
            "af_siteid": nil,
            "af_message": "organic install",
            "\(AttributionKeys.AppsFlyer.adID)": "23847301457860211",
            "\(AttributionKeys.AppsFlyer.campaign)": "0111 - mm - aaa - US - best creo 10 - Copy",
            "\(AttributionKeys.AppsFlyer.adSet)": "0005 - tm - aaa - US - best 8",
            "\(AttributionKeys.AppsFlyer.adKeywords)": "keywords for ad",
            "\(AttributionKeys.ip)": AttributionDataMigratorTests.defaultIp,
            "\(AttributionKeys.idfa)": idfa,
            "\(AttributionKeys.idfv)": idfv
        ]
        if addAppsFlyerId {
            appsFlyerData[AttributionKeys.AppsFlyer.id.rawValue] = "110116141-131918411"
        }
        if addNetworkID {
            appsFlyerData[AttributionKeys.networkID.rawValue] = "10f0c0000aca0b00000fb0000c0f0f00"
        }
        if addChannel {
            appsFlyerData[AttributionKeys.AppsFlyer.channel.rawValue] = "Facebook"
        }
        if addMediaSource {
            appsFlyerData[AttributionKeys.AppsFlyer.mediaSource.rawValue] = "Facebook Ads"
        }
        if addAd {
            appsFlyerData[AttributionKeys.AppsFlyer.ad.rawValue] = "ad.mp4"
        }
        if addAdGroup {
            appsFlyerData[AttributionKeys.AppsFlyer.adGroup.rawValue] = "1111 - tm - aaa - US - 999 v1"
        }
        return appsFlyerData
    }

    private func branchData(with idfa: String? = defaultIdfa, idfv: String? = defaultIdfv) -> [String: Any?] {
        [
            "+is_first_session": false,
            "+clicked_branch_link": false,
            "\(AttributionKeys.Branch.channel)": "Facebook",
            "\(AttributionKeys.Branch.campaign)": "Facebook Ads 01293",
            "\(AttributionKeys.ip)": AttributionDataMigratorTests.defaultIp,
            "\(AttributionKeys.idfa)": idfa,
            "\(AttributionKeys.idfv)": idfv
        ]
    }

    private func mParticleData(with idfa: String? = defaultIdfa,
                               idfv: String? = defaultIdfv,
                               addMParticleId: Bool = true,
                               addNetworkID: Bool) -> [String: Any?] {
        var mParticleData: [String: Any?] = [
            "\(AttributionKeys.ip)": AttributionDataMigratorTests.defaultIp,
            "\(AttributionKeys.idfa)": idfa,
            "\(AttributionKeys.idfv)": idfv
        ]
        if addMParticleId {
            mParticleData[AttributionKeys.MParticle.id.rawValue] = "-2579252457900000000"
        }
        if addNetworkID {
            mParticleData[AttributionKeys.networkID.rawValue] = "10f0c0000aca0b00000fb0000c0f0f00"
        }
        return mParticleData
    }
}
