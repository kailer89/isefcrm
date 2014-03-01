class Admitido < ActiveRecord::Base
	belongs_to :inscrito
	belongs_to :status_de_admision
	belongs_to :status_de_la_notificacion
	belongs_to :status_del_admitido
	belongs_to :status_ref_pago_insc
	belongs_to :periodo_para_ingresar
	has_many :examinados, :dependent => :destroy
	accepts_nested_attributes_for :examinados, :reject_if => :all_blank, :allow_destroy => true
	has_paper_trail
end
