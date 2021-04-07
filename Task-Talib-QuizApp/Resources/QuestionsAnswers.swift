struct Questions: Codable {

        let answers : Answer?
        let question : String?

  
}

struct Answer : Codable {

        let a : String?
        let b : String?
        let c : String?
        let correct : String?

       

}

struct AnswerDetails{
    let a : String
    let b: String
    let c: String
    let correct : String 
}
