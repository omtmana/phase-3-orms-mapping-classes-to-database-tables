class Song

  attr_accessor :name, :album , :id

  def initialize(name:, album: , id:nil)
    @id = id
    @name = name
    @album = album
  end

  # creating a table 
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  # saves the songs created
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album)
      VALUES(?, ?)
    SQL
  DB[:conn].execute(sql, self.name, self.album);

  #getting the ID from database && save to ruby instance
  self.id = DB[:conn].execute("SELECT id FROM songs")[0][0]
  self
  end

  # creating and saving to the database
  def self.create(name: , album:)
      song = Song.new(name:name, album:album)
      song.save
  end

end
