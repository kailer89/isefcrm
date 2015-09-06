class ExaminadosController < ApplicationController
  before_filter :authenticate_user!
  
  helper_method :sort_column, :sort_direction
  # GET /solicitantes
  # GET /solicitantes.json
  def index
    archivado = false
    modelo = Configuracione.where(:user_id=>current_user.id).first rescue nil
    if modelo != nil
      archivado = modelo.mostrar_archivados
    end  
    if modelo == nil     
    @examinados = Examinado.where(:isadmitido=>false).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
    else
      @examinados = Examinado.where(:archivado=>archivado).where(:isadmitido=>false).order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
    end
        rol = Role.where(:id=>current_user.role).first

    if rol.nombre == "D" or rol.nombre == "ACRM" or rol.nombre == "AL" or rol.nombre == "A"   or rol.nombre == "CP"  
      logger.debug "admin"
    else
      @examinados = @examinados.where("solicitante_id in (:solicitantes)",:solicitantes=>Solicitante.where("prospecto_id in (:prospectos)",:prospectos=>Prospecto.where(:sede_id=>current_user.sede).joins{solicitante}.where(:user_id=>current_user.id)))
    end    

      @q = @examinados.ransack(params[:q])
      @q.build_grouping unless @q.groupings.any?
      @examinados  = params[:distinct].to_i.zero? ? @q.result.paginate(:per_page => 50, :page => params[:page])  : @q.result(distinct: true).paginate(:per_page => 50, :page => params[:page]) 

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @examinados }
      format.xls
    end
  end

  def printview
     @examinado = Examinado.find(params[:id])
    
    respond_to do |format|
       format.html {render :layout => false}
       format.pdf {
         render :pdf => "printview", :header => { :font_size => '8', :right => '[page] of [toPage]' }, :footer => {:font_size => '8', :right => 'Generated by jottinx.com' }
      }
    end

  end

  def printviewpdf
    @examinado = Examinado.find(params[:id])

    email = render_to_string(:action => 'printview', :layout => false)  
    email = PDFKit.new(email)    
    email = email.to_pdf  
    nombredelpdf="#{@examinado.id} - #{@examinado.solicitantes.first.prospectos.first.nombre} #{@examinado.solicitantes.first.prospectos.first.apellido_paterno} #{@examinado.solicitantes.first.prospectos.first.apellido_materno}.pdf"
    ProspectosMailer.email_a_pdf(current_user.email,nombredelpdf,@examinado, email).deliver  
      redirect_to :back 
  end  

  # GET /solicitantes/1
  # GET /solicitantes/1.json
  def show
    @examinado = Examinado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @examinado }
    end
  end

  # DELETE /prospectos/1
  # DELETE /prospectos/1.json
  def destroy
    @examinado = Examinado.find(params[:id])
    @examinado.destroy

    respond_to do |format|
      format.html { redirect_to examinados_path}
      format.json { head :ok }
    end
  end  

  # GET /solicitantes/new
  # GET /solicitantes/new.json
  def new
    redirect_to new_prospecto_path, :flash => { :info => "No es posible crear Examinados sin antes seguir el proceso" }    
    @examinado = Examinado.new
    #@solicitante.compartidos.build
    #@examinado.becacreditos.build

    respond_to do |format|
      format.html {redirect_to examinados_path, notice: 'No es posible agregar nuevos solicitantes sin antes agregar un solicitante.' }
      format.json { render json: @examinado }
    end
  end

  # GET /examinados/1/edit
  def edit
    @examinado = Examinado.find(params[:id])
    @prospecto = @examinado.solicitantes.first.prospectos.first
      if @prospecto!=nil
        @tareas1 = Tarea.where(:model_name=>"prospectos",:model_id=>@prospecto.id)
        @memos1 = Memo.where(:model_name=>"prospectos",:model_id=>@prospecto.id)
        @attachments1 = Attachment.where(:model_name=>"prospectos",:model_id=>@prospecto.id)
        @llamadas1 = Llamada.where(:model_name=>"prospectos",:model_id=>@prospecto.id)
        @correos1 = Correo.where(:model_name=>"prospectos",:model_id=>@prospecto.id)
        if @prospecto.solicitante_id != nil
          @solicitante = Solicitante.find(@prospecto.solicitante_id)
          @llamadas2 = Llamada.where(:model_name=>"solicitantes",:model_id=>@solicitante.id)
          @correos2 = Correo.where(:model_name=>"solicitantes",:model_id=>@solicitante.id)
          @attachments2 = Attachment.where(:model_name=>"solicitantes",:model_id=>@solicitante.id)
          @memos2 = Memo.where(:model_name=>"solicitantes",:model_id=>@solicitante.id)
          @tareas2 = Tarea.where(:model_name=>"solicitantes",:model_id=>@solicitante.id)
          #check if he has a examinado
          if @solicitante.examinado_id !=nil
            @examinado = Examinado.find(@solicitante.examinado_id)
            @tareas3 = Tarea.where(:model_name=>"examinados",:model_id=>@examinado.id)
            @memos3 = Memo.where(:model_name=>"examinados",:model_id=>@examinado.id)
            @correos3 = Correo.where(:model_name=>"examinados",:model_id=>@examinado.id)
            @attachments3 = Attachment.where(:model_name=>"examinados",:model_id=>@examinado.id)
            @llamadas3 = Llamada.where(:model_name=>"examinados",:model_id=>@examinado.id)
            
            #check if he has an admitido
            if @examinado.admitido_id !=nil
              @admitido = Admitido.find(@examinado.admitido_id)
              @tareas4 = Tarea.where(:model_name=>"admitidos",:model_id=>@admitido.id)
              @correos4 = Correo.where(:model_name=>"admitidos",:model_id=>@admitido.id)
              @attachments4 = Attachment.where(:model_name=>"admitidos",:model_id=>@admitido.id)
              @llamadas4 = Llamada.where(:model_name=>"admitidos",:model_id=>@admitido.id)
              @memos4 = Memo.where(:model_name=>"admitidos",:model_id=>@admitido.id)
              
              #check if he has an inscrito
              if @admitido.inscrito_id !=nil
                @inscrito = Inscrito.find(@admitido.inscrito_id)
                @tareas5 = Tarea.where(:model_name=>"inscritos",:model_id=>@inscrito.id)
                @memos5 = Memo.where(:model_name=>"inscritos",:model_id=>@inscrito.id)
                @correos5 = Correo.where(:model_name=>"inscritos",:model_id=>@inscrito.id)
                @attachments5 = Attachment.where(:model_name=>"inscritos",:model_id=>@inscrito.id)
                @llamadas5 = Llamada.where(:model_name=>"inscritos",:model_id=>@inscrito.id)
                
              end
            end
          end
        end
        end
      @tareas=[@tareas1,@tareas2,@tareas3,@tareas4,@tareas5].flatten.compact.sort
      @llamadas =[@llamadas1,@llamadas2,@llamadas3,@llamadas4,@llamadas5].flatten.compact.sort
      @memos =[@memos1,@memos2,@memos3,@memos4,@memos5].flatten.compact.sort
      @correos =[@correos1,@correos2,@correos3,@correos4,@correos5].flatten.compact.sort
      @attachments =[@attachments1,@attachments2,@attachments3,@attachments4,@attachments5].flatten.compact.sort       
    #@examinado.becacreditos.build
    #@prospeecto = Solicitante.prospecto
  end

  # POST /examinados
  # POST /examinados.json
  def create
    @examinado = Examinado.new(params[:examinado])

    respond_to do |format|
      if @examinado.save
        format.html { redirect_to @examinado, notice: 'Solicitante was successfully created.' }
        format.json { render json: @examinado, status: :created, location: @examinado }
      else
        format.html { render action: "new" }
        format.json { render json: @examinado.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PUT /examinados/1
  # PUT /examinados/1.json
  def update
    @examinado = Examinado.find(params[:id])

    respond_to do |format|
      if @examinado.update_attributes(params[:examinado])
        format.html { redirect_to @examinado, notice: 'Solicitante was successfully updated. #{undo_link}' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @examinado.errors, status: :unprocessable_entity }
      end
    end
  end

  def sort_column
    if params[:sort] !=nil
      params[:sort] 
    else
      "id"
    end
  end
  
  def sort_direction
    if params[:direction] != nil
        params[:direction]
    else
      "desc"
    end
  end  

  #convierte el prospecto en solicitante
  # POST /examinados/:id/convertir
  def convertir_examinado
    @examinado = Examinado.find(params[:id])
    @examinado.isadmitido=true
    @examinado.save

    examinado=@examinado
    newAdmitido=Admitido.create(:examinado_id=>examinado.id)
    newAdmitido.isinscrito = false
    newAdmitido.archivado =false
    newAdmitido.save
    @examinado.admitido_id = newAdmitido.id
    @examinado.save

    historial = History.new
    historial.model_name = "prospectos"
    historial.model_id = @examinado.solicitantes.first.prospectos.first.id
    historial.user_id = current_user.id
    historial.role = current_user.role        
    historial.action = "Convertido en Admitido"
    historial.save

    #new_user = User.new(old_user.attributes.merge(:login => "newlogin"))
    redirect_to edit_admitido_path(newAdmitido), :flash => { :info => "Examinado convertido en admitido." }
  end  
  private
    def undo_link
    view_context.link_to("undo", revert_version_path(@examinado.versions.scoped.last), :method => :post)
  end  
end
