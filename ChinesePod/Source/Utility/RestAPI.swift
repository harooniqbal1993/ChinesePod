//
//  RestAPI.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 21/12/2023.
//

import Foundation

public struct RestAPI{
    static let DOMAIN_0_6_0 = "https://chinesepod.com"
    static let API_VERSION = "1.0.0"
    static let CLIENT_ID = "chinesepodios"
    static let CLIENT_SECRET = "36db6f3d2540c36e45666f308a08f9ce8641e7e2"
    
//    static let DOMAIN_1_0_0 = "https://ws.chinesepod.com/%@/instances/%@"
    static let SERVER4_DOMAIN_1_0_0 = "https://server4.chinesepod.com:444/%@/instances/%@"
//    static let SERVER4_DOMAIN_1_0_0 = "https://ws.chinesepod.com:445/%@/instances/%@"
    
    static let LOGIN_API_1_0_0 = "/main/login"
    static let LOGOUT_API_1_0_0 = "/main/logout"
    static let SIGNUP_API_1_0_0 = "/main/create-user"
    static let COUNTRIES_API_1_0_0 = "/main/get-countries"
    static let CONFIRM_SIGNUP_API_1_0_0 = "/main/confirm-user"
    static let USER_INFO_API_1_0_0 = "/main/get-user-info"
    static let RESEND_CONFIRM_EMAIL_API_1_0_0 = "/main/resend-confirmation"
    static let UPLOAD_AVATAR_API_1_0_0 = "/main/upload-avatar"
    
    // User Info API
    static let UPDATE_USER_INFO_API_1_0_0 = "/main/update-user-info"
    static let CHANGE_PASSWORD = "/main/change-password"
    
    static let FETCH_COURSES_API_1_0_0 = "/courses/get-courses"
    static let FETCH_COURSE_API_1_0_0 = "/courses/view-course"
    static let SAVE_COURSE_API_1_0_0 = "/courses/save-course"
    static let UNSAVE_COURSE_API_1_0_0 = "/courses/unsave-course"
    static let FETCH_LATEST_COURSES_API_1_0_0 = "/courses/get-latest-courses"
    
    static let FETCH_LESSONS_API_1_0_0 = "/lessons/get-lessons-by"
    static let FETCH_FULL_LESSON_API_1_0_0 = "/lessons/get-full-lesson-detail"
    static let FETCH_LESSON_API_1_0_0 = "/lessons/get-lesson-detail"
    static let FETCH_LESSON_BY_SLUG_API_1_0_0 = "/lessons/get-lesson-detail-slug"
    static let CHANGE_LESSON_API_1_0_0 = "/lessons/change-status"
    static let FETCH_LATEST_LESSONS_API_1_0_0 = "/lessons/get-latest-lessons"
    
    static let FETCH_VOCABULARIES_API_1_0_0 = "/lessons/get-vocabulary"
    static let FETCH_GRAMMARS_API_1_0_0 = "/lessons/get-grammar"
    static let FETCH_EXPANSIONS_API_1_0_0 = "/lessons/get-expansion"
    static let FETCH_DIALOGUES_API_1_0_0 = "/lessons/get-dialogue"
    static let SUBSCRIBE_VALIDATION_API_1_0_0 = "/iap/subscribe"

    static let CREATE_DECK_API_1_0_0 = "/decks/create-deck"
    static let DELETE_DECK_API_1_0_0 = "/decks/delete-deck"
    static let RENAME_DECK_API_1_0_0 = "/decks/rename-deck"
    static let REMOVE_FROM_DECK_API_1_0_0 = "/decks/remove-from-deck"
    static let MOVE_TO_DECK_API_1_0_0 = "/decks/move-to-deck"
    static let ADD_WORD_API_1_0_0 = "/decks/add-word"
    static let SEARCH_WROD_API_1_0_0 = "/decks/search-words"
    static let GET_WORD_API_1_0_0 = "/decks/get-words"
    static let GET_DECKS_API_1_0_0 = "/decks/get-decks"
    static let UPDATE_WORD_STATUS_API_1_0_0 = "/decks/update-word-status"
    static let GET_RANDOMIZE_WORD_API_1_0_0 = "/decks/get-deck-words"
    static let FORGOT_PASSWORD_API_1_0_0 = "/main/forgot-password"
    static let RESET_PASSWORD_API_1_0_0 = "/main/renew-password"
    static let GET_LESSON_COMMENTS_API_1_0_0 = "/lessons/comments/get-comments"
    static let ADD_LESSON_COMMENT_API_1_0_0 = "/lessons/comments/add-comment"
    static let ADD_LESSON_REPLY_TO_COMMENT_API_1_0_0 = "/lessons/comments/add-reply-to-comment"
    static let ADD_DELETE_LESSON_COMMENT_API_1_0_0 = "/lessons/comments/delete-comment"
    static let DICTIONARY_GET_WORDS_API_1_0_0 = "/dictionary/get-words"
    
    // WISTIA
    static let WISTIA_DOMAIN = "https://api.wistia.com/%@"
    static let WISTIA_FETCH_MEDIAS_SHOW = "/medias/%@.json"
    static let WISTIA_CURRENT_VERSION = "v1"
    static let WISTIA_TOKEN = "249b1eb35657c64c3d453b3b3839774dcc276fa2"
    
    public static func GetFullUrl(_ api:String) -> String{
        return DOMAIN_0_6_0 + "/api/" + API_VERSION + api
    }
    
    public static func GetFullUrl(_ api:String,version:String) -> String{
        if(version == "1.0.0"){
            return String(format: SERVER4_DOMAIN_1_0_0, version,"prod") + api
        }else{
            return DOMAIN_0_6_0 + "/api/" + version + api
        }
    }
    
    public static func GetWistiaFullUrl(_ api:String,version:String) -> String{
        return String(format: WISTIA_DOMAIN, version) + api
    }
}
