//
//  HomeModel.swift
//  ChinesePod
//
//  Created by Haroon Iqbal on 26/12/2023.
//

import Foundation

struct LessonResponseModel: Decodable {
    
    var id:String?
    var title:String?
    var level:Int?
    var slug:String?
    var image:String?
    var introduction:String?
    var bookmarked:Bool = false
    var studied:Bool = false
    var free:Bool = false
    var video:String?
    var high_quality_mp3:String?
    var radio_quality_mp3:String?
    var dialogue_mp3:String?
    var review_mp3:String?
    var vocabularies:[KeyVocabulary]?
    var grammars:[Grammar]?
    var dialogues:[Dialogue]?
    var expansions:[ExpansionCollection]?
    var lesson_plan:String?
    
    enum CodingKeys: String, CodingKey {
        case id    = "v3_id"
//        case msg            = "msg"
//        case Images         = "pro_data"
    }
}

struct KeyVocabulary: Decodable {
    var vocabularyId:String?
    var vocabulary_class:String?
    var lessonId:String?
    var display_order:Int?
    var image:String?
    var source:String?
    var pinyin:String?
    var target:String?
    var source_t:String?
    var vcid:String?
    var audio:String?
}

struct Grammar: Decodable {
    var grammar_id:String?
    var name:String?
    var introduction:String?
    var related_grammar:String?
    var summary:String?
    var level_id:String?
    var image:String?
    var parent_id:String?
    var tree:String?
    var display_type:String?
    var display_layer:String?
    var display_sort:String?
    var production_id:String?
    var create_time:String?
    var update_time:String?
    var level_name:String?
    var path:String?
    var sentences:[Sentence]?
}

struct Sentence: Decodable {
    var grammar_block_id:String?
    var myDescription:String?
    var summary:String?
    var display_sort:String?
    var grammar_id:String?
    var create_time:String?
    var update_time:String?
    var grammar_sentence_id:String?
    var is_correct:String?
    var target:String?
    var target_trad:String?
    var target_annotate:String?
    var target_audio:String?
    var source:String?
    var source_trad:String?
    var source_audio:String?
    var tips:String?
    var pinyin:String?
    var words:[Word]?
    var source_t:String?
    var audio:String?
}

struct Word: Decodable {
    var source:String?
    var target:String?
    var lessonId:String?
    var vcid:String?
    var wordId:String?
    var audio:String?
    var pinyin:String?
    var source_t:String?
}

struct Dialogue: Decodable {
    var dialogueId:String?
    var lessonId:String?
    var display_order:Int?
    var vocabulary:String?
    var speaker:String?
    var row_3:String?
    var row_4:String?
    var source:String?
    var sentence_words:[Word]?
    var source_t:String?
    var pinyin:String?
    var target:String?
    var audio:String?
}

struct ExpansionCollection: Decodable {
    var key:String?
    var expansions:[Expansion]?
}

struct Expansion: Decodable {
    var expansionId:String?
    var audio:String?
    var source:String?
    var source_t:String?
    var pinyin:String?
    var target:String?
    var expansion_word:[Word]?
}
