class TextExporter
  attr_accessor :collection, :fields

  def initialize(collection, fields)
    @collection = collection
    @fields = fields
  end

  def generate(options = {})
    CSV.generate(options.merge(col_sep: "\t")) do |csv|
      csv << fields
      collection.each do |item|
        csv << item.attributes.values_at(*fields).map { |value| "#{value}".gsub(/\s+/, ' ') }
      end
    end
  end

  def self.to_csv(collection, fields)
    new(collection, fields).generate
  end
end
