//
//  MovieViewModel.swift
//  MovieFlixApp
//
//  Created by Heena Mujawar on 12/06/20.
//  Copyright © 2020 Heena Mujawar. All rights reserved.
//
//
import Foundation

protocol CustomProtocol {
    func dateFormated(dateString:String) -> String
}

struct MovieDetailViewModel : CustomProtocol{
    var movieModel:Results!
    
    var movieTitle:String {
        return self.movieModel.original_title!
    }
    var overView:String {
        return self.movieModel.overview!
    }
    var releaseData: String {
        return self.dateFormated(dateString: self.movieModel.release_date!)
    }
    var rating: String {
        return (String(describing: self.movieModel.vote_average!))
    }
    var duration:String {
        return  (String(describing: self.movieModel.popularity!))
    }
    var posterImage: String {
        return  "\(UrlStr.backdropUrl.rawValue)\(self.movieModel.backdrop_path ?? "")"
    }
    
    init(movieModel:Results){
        self.movieModel = movieModel
    }
    
    func dateFormated(dateString: String) -> String {
        
        let dateFormatter = DateFormatter(format: "yyyy-dd-mm")
        let date = Date()
        return dateString.toDateString(dateFormatter: dateFormatter, outputFormat: "MMMM dd, yyyy")!
    }
}

extension DateFormatter {

    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {

    func toDate (dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }

    func toDateString (dateFormatter: DateFormatter, outputFormat: String) -> String? {
        guard let date = toDate(dateFormatter: dateFormatter) else { return nil }
        return DateFormatter(format: outputFormat).string(from: date)
    }
}

extension Date {
    func toString (dateFormatter: DateFormatter) -> String? {
        return dateFormatter.string(from: self)
    }
}
