//
//  APICaller.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 09/06/22.
//

import Foundation


struct Constant {
    static let APIKey = "5555294f1a5b65a9c40e3d93183c96c7"
    static let baseURL = "https://api.themoviedb.org"
    static let YouTubeAPI_KEY = "AIzaSyAwkKoq4eqry_lyQonIU_9uLOP0FtEB4hI"
    static let YouTube_baseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: String, Error {
    case failedToGetData = "Error Occurred. Please, try again"
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/movie/day?api_key=\(Constant.APIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let trendingMovies = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(trendingMovies.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTVs(completion: @escaping (Result<[Title], APIError>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/trending/tv/day?api_key=\(Constant.APIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let trendingTvs = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(trendingTvs.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], APIError>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/upcoming?api_key=\(Constant.APIKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let upcomingMovies = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(upcomingMovies.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getPopularMovies(completion: @escaping (Result<[Title], APIError>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/popular?api_key=\(Constant.APIKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let popularMovies = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(popularMovies.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], APIError>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/movie/top_rated?api_key=\(Constant.APIKey)&language=en-US&page=1") else { return }
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let topRatedMovies = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(topRatedMovies.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], APIError>) -> Void) {
        guard let url = URL(string: "\(Constant.baseURL)/3/discover/movie?api_key=\(Constant.APIKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let discoverMovies = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(discoverMovies.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func search(with query: String, completion: @escaping (Result<[Title], APIError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constant.baseURL)/3/search/movie?api_key=\(Constant.APIKey)&query=\(query)") else { return }
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let discoverMovies = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(discoverMovies.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }

    
    func getYouTubeVideo(with query: String, completion: @escaping (Result<VideoElement, APIError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constant.YouTube_baseURL)q=\(query)&key=\(Constant.YouTubeAPI_KEY)") else { return }
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let youTubeVideos = try JSONDecoder().decode(YouTubeSearchResults.self, from: data)
                completion(.success(youTubeVideos.items[0]))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
}
