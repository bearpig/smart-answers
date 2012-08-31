module SmartAnswer::Calculators
  class CommodityCodeCalculator
    
    attr_reader :matrix_data, :commodity_code_matrix
    attr_accessor :milk_protein_weight
    
    def initialize(weights)
      load_maxtrix_data
      populate_commodity_code_matrix
      
#      ["starch_glucose_weight", "sucrose_weight", "milk_fat_weight", "milk_protein_weight"].each do |n|
#        send("@#{n}=", weights[n.to_sym].to_i)
#      end

      @starch_glucose_weight = weights[:starch_glucose_weight].to_i
      @sucrose_weight = weights[:sucrose_weight].to_i
      @milk_fat_weight = weights[:milk_fat_weight].to_i
      @milk_protein_weight = weights[:milk_protein_weight].to_i
    end
    
    def commodity_code
      # puts "@commodity_code_matrix[#{milk_fat_milk_protein_index}][#{glucose_sucrose_index}] : #{@commodity_code_matrix[milk_fat_milk_protein_index][glucose_sucrose_index]}"
      @commodity_code_matrix[milk_fat_milk_protein_index][glucose_sucrose_index]  
    end
    
    def glucose_sucrose_index
      starch_glucose_to_sucrose[@starch_glucose_weight][@sucrose_weight]
    end
    
    def milk_fat_milk_protein_index
      milk_fat_to_milk_protein[@milk_fat_weight][@milk_protein_weight]
    end
    
    def populate_commodity_code_matrix
      # TODO: Find an elegant way of doing this...
      @commodity_code_matrix = []
      @matrix_data[:commodity_code_matrix].each_line { |l| @commodity_code_matrix << l.split }
    end
    
    def starch_glucose_to_sucrose
      @matrix_data[:starch_glucose_to_sucrose]
    end
    
    def milk_fat_to_milk_protein
      @matrix_data[:milk_fat_to_milk_protein]
    end
    
    def load_maxtrix_data
      @matrix_data ||= YAML.load(File.open("lib/data/commodity_codes_data.yml").read)  
    end    
  end
end
