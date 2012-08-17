require 'rubygems'
require 'mongo'
require 'bson'
require 'json'
require 'uri'

class Repository
  class << self
    @@db = nil
    @@connection = nil

    def db 
      return @@db if @db
      db = URI.parse(ENV['MONGOHQ_URL'])
      db_name = db.path.gsub(/^\//, '')
      @@db = Mongo::Connection.new(db.host, db.port).db(db_name)
      @@db.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
      @@db
    end

    def submissions
      db["submissions"].find.map { |item| item }
    end

    def submissions_sorted(sortby="timestamp")
      db["submissions"].find({}, :sort => sortby).map { |item| item }
    end

    def save_submission(submission)
      save_entity("submissions", submission)
    end

    def save_entity(entity_name, entity)
      db[entity_name].save entity
      puts "Repository: document saved to #{entity_name}"
    end

  end
end
