class GruposController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /grupos
  # GET /grupos.json
  def index
    @grupos = Grupo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grupos }
    end
  end

  # GET /grupos/1
  # GET /grupos/1.json
  def show
    @grupo = Grupo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grupo }
    end
  end

  # GET /grupos/new
  # GET /grupos/new.json
  def new
    @grupo = Grupo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grupo }
    end
  end

  # GET /grupos/1/edit
  def edit
    @grupo = Grupo.find(params[:id])
    @tareas = Tarea.where(:model_name=>"grupos",:model_id=>@grupo.id)
    @memos = Memo.where(:model_name=>"grupos",:model_id=>@grupo.id)
    @attachments = Attachment.where(:model_name=>"grupos",:model_id=>@grupo.id)
    @llamadas = Llamada.where(:model_name=>"grupos",:model_id=>@grupo.id)
    @correos = Correo.where(:model_name=>"grupos",:model_id=>@grupo.id)


  end

  # POST /grupos
  # POST /grupos.json
  def create
    @grupo = Grupo.new(params[:grupo])

    respond_to do |format|
      if @grupo.save
        format.html { redirect_to @grupo, notice: 'Grupo was successfully created.' }
        format.json { render json: @grupo, status: :created, location: @grupo }
      else
        format.html { render action: "new" }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grupos/1
  # PUT /grupos/1.json
  def update
    @grupo = Grupo.find(params[:id])

    respond_to do |format|
      if @grupo.update_attributes(params[:grupo])
        format.html { redirect_to @grupo, notice: 'Grupo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupos/1
  # DELETE /grupos/1.json
  def destroy


rol = Role.where(:id=>current_user.role).first
        if rol.nombre == "ACRM"

    
    @grupo = Grupo.find(params[:id])
    @grupo.destroy
else
  flash[:error] ='No tienes permiso para realizar esta accion'

end


    respond_to do |format|
      format.html { redirect_to grupos_url }
      format.json { head :ok }
    end
  end
end
