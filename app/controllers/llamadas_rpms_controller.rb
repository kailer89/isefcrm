class LlamadasRpmsController < ApplicationController
  before_filter :set_llamadas_rpm, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @llamadas_rpms = LlamadasRpm.all
    respond_with(@llamadas_rpms)
  end

  def show
    respond_with(@llamadas_rpm)
  end

  def new
    @llamadas_rpm = LlamadasRpm.new
    respond_with(@llamadas_rpm)
  end

  def edit
  end

  def create
    @llamadas_rpm = LlamadasRpm.new(params[:llamadas_rpm])
    @llamadas_rpm.save

    redirect_to imprimir_llamadas_rpm_path(format: :xls)
    return
  end

  def imprimir_llamadas_rpm

    @rol = Role.where(:id=>current_user.role).first.nombre
    @llamadas =nil

    if @rol == "ACRM" or @rol == "DN"
          
          @llamadas = Llamada.where{user_id!=nil}
          
    elsif @rol == "CP" or @rol == "D"
            
          @llamadas = Llamada.where(:sede_id=>current_user.sede.id)
          
    else
            
          @llamadas = Llamada.where(:sede_id=>current_user.sede.id).where(:user_id=>current_user.id)
          
    end
  end

  def update
    @llamadas_rpm.update_attributes(params[:llamadas_rpm])
    respond_with(@llamadas_rpm)
  end

  def destroy
    @llamadas_rpm.destroy
    respond_with(@llamadas_rpm)
  end

  private
    def set_llamadas_rpm
      @llamadas_rpm = LlamadasRpm.find(params[:id])
    end
end
