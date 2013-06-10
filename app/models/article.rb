class Article
  include Mongoid::Document
  field :title
  field :content, type: String
end
