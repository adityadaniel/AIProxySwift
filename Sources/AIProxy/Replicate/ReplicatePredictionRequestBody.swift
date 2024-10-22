//
//  ReplicatePredictionRequestBody.swift
//
//
//  Created by Lou Zell on 8/27/24.
//

import Foundation

/// The request body for creating a Replicate prediction:
/// https://replicate.com/docs/reference/http#create-a-prediction
public struct ReplicatePredictionRequestBody: Encodable {
    /// The replicate input schema, for example ReplicateSDXLInputSchema
    public let input: Encodable

    /// The version of the model to run
    public let version: String?
    
    public let webhookURL: URL?
    
    public let webhookEventsFilter: [ReplicateWebhookFilterEvent]

    public init(
        input: any Encodable,
        version: String? = nil,
        webhookURL: URL? = nil,
        webhookEventsFilter: [ReplicateWebhookFilterEvent] = []
    ) {
        self.input = input
        self.version = version
        self.webhookURL = webhookURL
        self.webhookEventsFilter = webhookEventsFilter
    }

    private enum RootKey: String, CodingKey {
        case input
        case version
        case webhookURL = "webhook"
        case webhookEventsFilter = "webhook_events_filter"
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: RootKey.self)
        try container.encode(self.input, forKey: .input)
        try container.encodeIfPresent(self.version, forKey: .version)
        try container.encodeIfPresent(self.webhookURL, forKey: .webhookURL)
        try container.encodeIfPresent(self.webhookEventsFilter, forKey: .webhookEventsFilter)
    }
}

