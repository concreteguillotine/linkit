class Post < ApplicationRecord
    acts_as_votable
    has_one_attached :image
    has_many :comments, dependent: :destroy
    belongs_to :author, class_name: "User"
    has_and_belongs_to_many :tags

    URL_FORMATS = {
        regular: /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=(?<id>[^&]+)/,
        shortened: /^(https?:\/\/)?(www\.)?youtu.be\/(?<id>[^&]+)/,
        embed: /^(https?:\/\/)?(www\.)?youtube.com\/embed\/(?<id>[^&]+)/,
        embed_as3: /^(https?:\/\/)?(www\.)?youtube.com\/v\/(?<id>[^?]+)/,
        chromeless_as3: /^(https?:\/\/)?(www\.)?youtube.com\/apiplayer\?video_id=(?<id>[^&]+)/
    }
  
    INVALID_CHARS = /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/
  
    def self.has_invalid_chars?(youtubeurl)
      !INVALID_CHARS.match(youtubeurl).nil?
    end
  
    def self.extract_video_id(youtubeurl)
      return nil if has_invalid_chars?(youtubeurl)
  
      URL_FORMATS.values.each do |format_regex|
        match = format_regex.match(youtubeurl)
        return match[:id] if match
      end
    end
  
    def self.youtube_embed_url(youtubeurl)
      vid_id = extract_video_id(youtubeurl)
      "http://www.youtube.com/embed/#{vid_id}"
    end
end
