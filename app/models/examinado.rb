class Examinado < ActiveRecord::Base
	belongs_to :admitido
	belongs_to :status_del_examinado_paa
	belongs_to :status_del_examinado_psico
	belongs_to :status_del_examinado_entrevistum
	
	has_many :solicitantes, :dependent => :destroy
	accepts_nested_attributes_for :solicitantes, :reject_if => :all_blank, :allow_destroy => true
	has_paper_trail
end
