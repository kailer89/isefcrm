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
