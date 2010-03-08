module ActsAsBr
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_br_date(*mets)
      
      arr = mets.map {|m| ":#{m}"}.join(', ')
      c1 = <<-C1
        validates_each #{arr} do |rec, att, val|
          dtb = rec.read_attribute_before_type_cast(att.to_s)
          #unless dtb.blank?
          #  dt = Date.parse(dtb) rescue nil
          #  rec.errors.add att, "Data Inválida \#{dtb}" unless dt
          #end
        end
      C1
      #RAILS_DEFAULT_LOGGER.debug c1
      module_eval c1
      
      mets.each do |met|
        
        define_method("#{met.to_s}_to_form=") do |dt|  
          if /(\d{2})\/(\d{2})\/(\d{4})/.match(dt)
            dt = "#{$3}-#{$2}-#{$1}"
          end
          write_attribute(met.to_sym, dt)          
        end
        
        define_method("#{met.to_s}_to_form") do
          read_attribute(met.to_sym).try(:strftime, "%d/%m/%Y")
        end
        
      end # - each

    end # - acts_as...

    def acts_as_br_currency(*mets)

      mets.each do |met|

        define_method("#{met.to_s}_to_form=") do |dt|
          dt.gsub!("R$", "")
          dt.gsub!(".", "")
          dt.gsub!(",", ".")
          write_attribute(met.to_sym, dt)          
        end

        define_method("#{met.to_s}_to_form") do
          read_attribute(met.to_sym).try(:*, 10)
        end

      end # - each

    end # - acts_as...
  end # module ClassMethods
  
end # module ActsAsBr

class String
  def data_valida?
    invertida = ''
    if /(\d{2})\/(\d{2})\/(\d{4})/.match(self)
      invertida = "#{$3}-#{$2}-#{$1}"
    end
    data = Date.parse(invertida) rescue nil
    !data.nil?
  end
end