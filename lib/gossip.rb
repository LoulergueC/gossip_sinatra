class Gossip
    attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        all_gossips = []
        CSV.foreach("./db/gossip.csv") do |row|
            all_gossips << Gossip.new(row[0], row[1])
        end
        return all_gossips
    end

    def self.find(id)
        Gossip.all[id]
    end

    def self.update(id, new_author, new_content)
        csv_file_path = './db/gossip.csv'

        csv_data = CSV.read(csv_file_path)

        # Index de la ligne à modifier
        line_to_modify = id

        # Votre nouvelle donnée pour la ligne
        new_data = [new_author, new_content]

        # Modifier la ligne spécifique
        csv_data[line_to_modify] = new_data

        # Ouvrir le fichier en mode écriture
        CSV.open(csv_file_path, 'w') do |csv|
            csv_data.each do |row|
                csv << row
            end
        end
    end
end