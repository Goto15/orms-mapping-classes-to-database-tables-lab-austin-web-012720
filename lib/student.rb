class Student

  attr_reader :name, :grade, :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id

  end

  # Class Methods
  def self.create(attr_hash)
    student = Student.new(attr_hash[:name], attr_hash[:grade])
    student.save
    student
  end

  def self.create_table
    sql = <<-SQL 
          CREATE TABLE IF NOT EXISTS students (
            id INTEGER PRIMARY KEY,
            name TEXT,
            grade INTEGER
          )
          SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
          DROP TABLE students
          SQL
    DB[:conn].execute(sql)
  end

  # Instance Methods
  def save
    sql = <<-SQL
          INSERT INTO students (name, grade) 
          VALUES (? , ?)
          SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
