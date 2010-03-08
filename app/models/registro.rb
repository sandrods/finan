class Registro < ActiveRecord::Base
  
  acts_as_br_date :data
  acts_as_br_currency :valor
  
  validates_presence_of :data, :descricao, :valor, :cd
  
  named_scope :creditos, :conditions => {:cd=>'C'}
  named_scope :debitos, :conditions => {:cd=>'D'}

end
