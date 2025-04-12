import Foundation

public struct DynamicQuestion: Codable {
    public let type: String
    public let question: String
    public let labels: [String]?
    public let options: [String]?
    public let inputPrompt: String?
    public let responseMessage: String?
    public let invalidMessage: String?

    public init(type: String, question: String, labels: [String]? = nil, options: [String]? = nil,
                inputPrompt: String? = nil, responseMessage: String? = nil, invalidMessage: String? = nil) {
        self.type = type
        self.question = question
        self.labels = labels
        self.options = options
        self.inputPrompt = inputPrompt
        self.responseMessage = responseMessage
        self.invalidMessage = invalidMessage
    }

    public var effectiveInputPrompt: String {
        inputPrompt ?? (type == "text" ? "Enter your answer: " : "Choose an option: ")
    }

    public var effectiveResponseMessage: String {
        responseMessage ?? (type == "text" ? "You said: {{response}}" : "Selected: {{option}} ({{label}})")
    }

    public var effectiveInvalidMessage: String {
        invalidMessage ?? "Invalid input. Please try again."
    }
}
