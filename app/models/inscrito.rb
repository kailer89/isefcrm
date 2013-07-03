class Inscrito < ActiveRecord::Base
	has_many :admitidos, :dependent => :destroy
	belongs_to :status_de_la_inscripcion
	belongs_to :status_del_pago_de_la_inscripcion
	accepts_nested_attributes_for :admitidos, :reject_if => :all_blank, :allow_destroy => true	
	has_paper_trail
end
