class Comments
    attr_accessor :id_associated, :author, :content
    
    def initialize(id_associated, author, content)
        @author = author
        @content = content
        @id_associated = id_associated
    end

    def save
        CSV.open("./db/comments.csv", "ab") do |csv|
            csv << [@id_associated, @author, @content]
        end
    end

    def self.show(id)
        comments = []
        CSV.foreach("./db/comments.csv") do |row|
            if row[0] == id
                comments << Comments.new(row[0], row[1], row[2])
            end
        end
        return comments
    end

end