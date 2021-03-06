class ContactosController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /contactos
  # GET /contactos.json
  def index

    rol = Role.where(:id=>current_user.role).first

      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        @contactos = Contacto.all
      else
        @contactos = Contacto.where(:sede_id=>current_user.sede_id)
      end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contactos }
    end
  end

  # GET /contactos/1
  # GET /contactos/1.json
  def show
    @contacto = Contacto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contacto }
    end
  end

  # GET /contactos/new
  # GET /contactos/new.json
  def new
    @contacto = Contacto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contacto }
    end
  end

  # GET /contactos/1/edit
  def edit
    @contacto = Contacto.find(params[:id])
  end

  # POST /contactos
  # POST /contactos.json
  def create
    @contacto = Contacto.new(params[:contacto])

    respond_to do |format|
      if @contacto.save
        format.html { redirect_to @contacto, notice: 'Contacto was successfully created.' }
        format.json { render json: @contacto, status: :created, location: @contacto }
      else
        format.html { render action: "new" }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contactos/1
  # PUT /contactos/1.json
  def update
    @contacto = Contacto.find(params[:id])

    respond_to do |format|
      if @contacto.update_attributes(params[:contacto])
        format.html { redirect_to @contacto, notice: 'Contacto was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactos/1
  # DELETE /contactos/1.json
  def destroy

rol = Role.where(:id=>current_user.role).first


        if rol.nombre == "ACRM"


    

    @contacto = Contacto.find(params[:id])
    @contacto.destroy


else
  flash[:error] ='No tienes permiso para realizar esta accion'

end
    
    respond_to do |format|
      format.html { redirect_to contactos_url }
      format.json { head :ok }
    end
  end
end
