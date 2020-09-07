//
//  ParserTests.swift
//  UnitTests
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

@testable import OceanHero
import XCTest
import Core

class ParserTests: XCTestCase {
    var apiParser: APIParser!
    
    enum JSONFile: String {
        case Empty
        
        case ConfigResponseCorrect
        case ConfigResponseWrongFormat
        case ConfigResponseMissingTimestamp
        case ConfigResponseMissingData
        
        case ChallengesResponseCorrect
        case ChallengesResponseWrongFormat
        case ChallengesResponseMissingTimestamp
        case ChallengesResponseMissingData
        case ChallengesResponseMissingItems
        
        case MyChallengesResponseCorrect
        case MyChallengesResponseWrongFormat
        case MyChallengesResponseMissingTimestamp
        case MyChallengesResponseMissingData
        case MyChallengesResponseMissingItems
        
        case ChallengesShortResponseCorrect
        case ChallengesShortResponseWrongFormat
        case ChallengesShortResponseMissingTimestamp
        case ChallengesShortResponseMissingData
        case ChallengesShortResponseMissingItems
        
        case ChallengeResponseCorrect
        case ChallengeResponseWrongFormat
        case ChallengeResponseMissingTimestamp
        case ChallengeResponseMissingData
        
        case ChallengeShortResponseCorrect
        case ChallengeShortResponseWrongFormat
        case ChallengeShortResponseMissingTimestamp
        case ChallengeShortResponseMissingData
        
        case CreateChallengeResponseCorrect
        case CreateChallengeResponseWrongFormat
        case CreateChallengeResponseMissingTimestamp
        case CreateChallengeResponseMissingData
        
        case IdeasResponseCorrect
        case IdeasResponseWrongFormat
        case IdeasResponseMissingTimestamp
        case IdeasResponseMissingData
        case IdeasResponseMissingItems
        
        case MyIdeasResponseCorrect
        case MyIdeasResponseWrongFormat
        case MyIdeasResponseMissingTimestamp
        case MyIdeasResponseMissingData
        case MyIdeasResponseMissingItems
        
        case IdeaResponseCorrect
        case IdeaResponseWrongFormat
        case IdeaResponseMissingTimestamp
        case IdeaResponseMissingData
        
        case CreateIdeaResponseCorrect
        case CreateIdeaResponseWrongFormat
        case CreateIdeaResponseMissingTimestamp
        case CreateIdeaResponseMissingData
        
        case ExperimentsResponseCorrect
        case ExperimentsResponseWrongFormat
        case ExperimentsResponseMissingTimestamp
        case ExperimentsResponseMissingData
        case ExperimentsResponseMissingItems
        
        case MyExperimentsResponseCorrect
        case MyExperimentsResponseWrongFormat
        case MyExperimentsResponseMissingTimestamp
        case MyExperimentsResponseMissingData
        case MyExperimentsResponseMissingItems
        
        case ExperimentResponseCorrect
        case ExperimentResponseWrongFormat
        case ExperimentResponseMissingTimestamp
        case ExperimentResponseMissingData
        
        case ExperimentsOutcomesResponseCorrect
        case ExperimentsOutcomesResponseMissingItems
        
        case ExperimentsArchivedResponseCorrect
        case ExperimentsArchivedResponseMissingItems
        
        case WhatsHotResponseCorrect
        case WhatsHotResponseWrongFormat
        case WhatsHotResponseMissingTimestamp
        case WhatsHotResponseMissingData
        case WhatsHotResponseMissingItems
        
        case ActivityFeedResponseCorrect
        case ActivityFeedResponseWrongFormat
        case ActivityFeedResponseMissingTimestamp
        case ActivityFeedResponseMissingData
        case ActivityFeedResponseMissingItems

        case AuthenticateResponseCorrect
        case AuthenticateResponseWrongFormat
        case AuthenticateResponseMissingTimestamp
        case AuthenticateResponseMissingData
        
        case CommentsResponseCorrect
        case CommentsResponseWrongFormat
        case CommentsResponseMissingTimestamp
        case CommentsResponseMissingData
        case CommentsResponseMissingItems
        
        case ManagerRoleResponseCorrect
        case ManagerRoleResponseWrongFormat
        case ManagerRoleResponseMissingTimestamp
        case ManagerRoleResponseMissingData
        case ManagerRoleResponseMissingItems
        
        case ParticipationRoleResponseCorrect
        case ParticipationRoleResponseWrongFormat
        case ParticipationRoleResponseMissingTimestamp
        case ParticipationRoleResponseMissingData
        case ParticipationRoleResponseMissingItems
        
        case PeopleResponseCorrect
        case PeopleResponseWrongFormat
        case PeopleResponseMissingTimestamp
        case PeopleResponseMissingData
        case PeopleResponseMissingItems
        
        case FavouritesResponseCorrect
        case FavouritesResponseWrongFormat
        case FavouritesResponseMissingTimestamp
        case FavouritesResponseMissingData
        case FavouritesResponseMissingItems
        
        case ImageResponseCorrect
        case ImageResponseWrongFormat
    }
    
    enum HTTPResponseCode: Int {
        case ok = 200
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case notExistingError = 9999
    }
    
    override func setUp() {
        super.setUp()
        apiParser = APIParser()
    }
    
    override func tearDown() {
        apiParser = nil
        super.tearDown()
    }
}
