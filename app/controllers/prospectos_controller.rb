
class ProspectosController < ApplicationController
   
  before_filter :authenticate_user!
  
  def cambiarmultiple
    @valores = params
    @psm = params["/cambiarmultiple"]
    @q = getProspectosForUser(current_user).ransack(params[:q])
    @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)

    if not @psm[:fieldvaluetext].present?
     redirect_to mostrarmultiple_path(:q=>params[:q]) , :flash => { :error => "Por favor seleccione un valor para el campo seleccionado." }
     return
    end
    @prospectos.update_all("#{@psm[:fieldname]} = #{@psm[:fieldvaluetext]}")


  end


  def mostrarmultiple
     archivado = false
    modelo = Configuracione.where(:user_id=>current_user.id).first rescue nil
    if modelo != nil
      archivado = modelo.mostrar_archivados
    end    
    # @prospectos = Prospecto.all
    # or (current_user.role =="director")
    logger.debug "-----------------------"
    logger.debug current_user.inspect
    logger.debug "--------------------"
    rol = Role.where(:id=>current_user.role).first

    if request.path_parameters[:format] != 'xls'
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
          @q = getProspectosForUser(current_user).ransack(params[:q])
          @prospectos = @q.result(:distinct => true).where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page]) 
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?        
      else
          @q = getProspectosForUser(current_user).ransack(params[:q])
          @prospectos = @q.result(:distinct => true).where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page]) 
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?            
      end
    else

      ini = params[:inicio]
      fin = params[:final]




      if rol.nombre == "DN" or rol.nombre == "ACRM"  
          @q = getProspectosForUser(current_user).ransack(params[:q])
          if ini != nil
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false).where{id>=ini}.where{id<=fin}
          else
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)
          end
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?        
      else
          @q = getProspectosForUser(current_user).ransack(params[:q])
          if ini != nil
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false).where{id>=ini.to_s}.where{id<=fin.to_s}
          else
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)
          end
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?            
      end
    end



  end
  
  def multiexport

      archivado = false
          modelo = Configuracione.where(:user_id=>current_user.id).first rescue nil
          if modelo != nil
            archivado = modelo.mostrar_archivados
          end

        rol = Role.where(:id=>current_user.role).first

        if rol == nil
          prsopectos =  Prospecto.where(:archivado=>archivado).where(:sede_id=>current_user.sede).where(:user_id=>current_user.id)
        else
          if rol.nombre == "DN" or rol.nombre == "ACRM" 
            prsopectos =  Prospecto.where(:archivado=>archivado)
          else
            if rol.nombre == "D" or rol.nombre == "CP"

              prsopectos =  Prospecto.where(:archivado=>archivado).where(:sede_id=>current_user.sede)
            else

              prsopectos =  Prospecto.where(:archivado=>archivado).where(:sede_id=>current_user.sede).where(:user_id=>current_user.id)
            end #end director
          end #end else rol nombre
        end #end else nil

    prsopectos = prsopectos.map{|c| [c.id] }.sort
    #.each_slice(3).to_a
    @finals = []
    arrays = prsopectos.each_slice(100).to_a

    arrays.each do |a|
      new_state = Itemn.new
      new_state.maximo = a.max
      new_state.minimo = a.min
      @finals.push(new_state)
    end

  end

  # GET /prospectos
  # GET /prospectos.json
  def index
    archivado = false
    modelo = Configuracione.where(:user_id=>current_user.id).first rescue nil
    if modelo != nil
      archivado = modelo.mostrar_archivados
    end  




setnil = false
    if params[:q] == nil 
    logger.debug "xxxxxxxxxxxxxxqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"
    logger.debug params[:q].inspect
    logger.debug "xxxxxxxxxxxxxxxxxxxxxqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq"

      begin
         params[:q] = JSON.parse(modelo.LastSearchProspecto)
        rescue => ex
          logger.debug ex.message
        end
    else
      setnil = true
    end          




    # @prospectos = Prospecto.all
    # or (current_user.role =="director")
    logger.debug "-----------------------"
    logger.debug current_user.inspect
    logger.debug "--------------------"
    rol = Role.where(:id=>current_user.role).first

    if request.path_parameters[:format] != 'xls'
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
          @q = getProspectosForUser(current_user).ransack(params[:q])
          @qx = getProspectosForUser(current_user).ransack(params[:q])
          @prospectos = @q.result(:distinct => true).where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page]) 
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?        
      else
          @q = getProspectosForUser(current_user).ransack(params[:q])
          @qx = getProspectosForUser(current_user).ransack(params[:q])
          @prospectos = @q.result(:distinct => true).where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page]) 
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?            
      end
    else

      ini = params[:inicio]
      fin = params[:final]




      if rol.nombre == "DN" or rol.nombre == "ACRM"  
          @q = getProspectosForUser(current_user).ransack(params[:q])
          @qx = getProspectosForUser(current_user).ransack(params[:q])
          if ini != nil
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)
          else
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)
          end
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?        
      else
          @q = getProspectosForUser(current_user).ransack(params[:q])
          @qx = getProspectosForUser(current_user).ransack(params[:q])
          if ini != nil
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)
          else
            @prospectos = @q.result(:distinct => true).where(:issolicitante=> false)
          end
          @q.build_condition if @q.conditions.empty?
          @q.build_sort if @q.sorts.empty?            
      end
    end
    


 if setnil == true
      modelo.update_attribute(:LastSearchProspecto, params[:q].to_json)
else
  modelo.update_attribute(:LastSearchProspecto, "")
end



    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prospectos }
      format.xls
    end
  end

  def advanced_search
    archivado = false
    modelo = Configuracione.where(:user_id=>current_user.id).first rescue nil
    if modelo != nil
      archivado = modelo.mostrar_archivados
    end  
        
    rol = Role.where(:id=>current_user.role).first
    if request.path_parameters[:format] != 'xls'
      if rol.nombre == "DN" or rol.nombre == "ACRM"  
        @q = getProspectosForUser(current_user).ransack(params[:q])
        @q.build_grouping unless @q.groupings.any?
        @prospectos  = params[:distinct].to_i.zero? ? @q.result.where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page])  : @q.result(distinct: true).where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page]) 
      else
        @q = getProspectosForUser(current_user).ransack(params[:q])
        @q.build_grouping unless @q.groupings.any?
        @prospectos  = params[:distinct].to_i.zero? ? @q.result.where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page])  : @q.result(distinct: true).where(:issolicitante=> false).paginate(:per_page => 50, :page => params[:page]) 
      end
    else
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        @q = getProspectosForUser(current_user).ransack(params[:q])
        @q.build_grouping unless @q.groupings.any?
        @prospectos  = params[:distinct].to_i.zero? ? @q.result.where(:issolicitante=> false) : @q.result(distinct: true).where(:archivado=>archivado).where(:issolicitante=> false)
      else
        @q = getProspectosForUser(current_user).ransack(params[:q])
        @q.build_grouping unless @q.groupings.any?
        @prospectos  = params[:distinct].to_i.zero? ? @q.result.where(:issolicitante=> false) : @q.result(distinct: true).where(:issolicitante=> false)
      end      
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @prospectos }
      format.xls
    end
  end

  def search
    index
    render :index
  end

  # GET /prospectos/1
  # GET /prospectos/1.json
  def show
    @prospecto = Prospecto.find(params[:id])
    @activities = PublicActivity::Activity.all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prospecto }
      format.pdf {
         render :pdf => "show", :header => { :font_size => '8', :right => '[page] of [toPage]' }, :footer => {:font_size => '8', :right => 'Generated by jottinx.com' }
      }
    end
  end

  # GET /prospectos/new
  # GET /prospectos/new.json
  def new
    @prospecto = Prospecto.new
    @prospecto.created_by = current_user.id
    @prospecto.user_id =current_user.id
    @prospecto.sede_id =current_user.sede_id
    @prospecto.direccions.build
    @prospecto.interes_basicos.build
    @prospecto.medio_de_contactos.build
    @prospecto.interes_academicos.build
    @prospecto.accion_estrategicas.build
    @prospecto.plan_de_descuentos.build
    @prospecto.importado_revisado=true
    @prospecto.validado=false
    @prospecto.issolicitante =false

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prospecto }
    end
  end

  def webtest
    render :layout => "layout_for_show_only"


  end

  # GET /prospectos/1/edit
  def edit
    @prospecto = Prospecto.find(params[:id])
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
    #if @prospecto.issolicitante
    #  redirect_to prospecto_path(@prospecto), :flash => { :info => "<h4 class='alert-heading'>Solicitante creado previamente!</h4>El prospecto es un solicitante ahora, porfavor dirigete a solicitantes para editarlo o haz click #{view_context.link_to('aqui', solicitante_path(@prospecto.solicitante_id))}.".html_safe }
    #end
  end

  def printview
    @prospecto = Prospecto.find(params[:id])
    
    respond_to do |format|
       format.html {render :layout => false}
       format.pdf {
         render :pdf => "printview", :header => { :font_size => '8', :right => '[page] of [toPage]' }, :footer => {:font_size => '8', :right => 'Generated by jottinx.com' }
      }
    end

  end

  def printviewpdf
    @prospecto = Prospecto.find(params[:id])

    email = render_to_string(:action => 'printview', :layout => false)  
    email = PDFKit.new(email)    
    email = email.to_pdf  
    nombredelpdf="#{@prospecto.id} - #{@prospecto.nombre} #{@prospecto.apellido_paterno} #{@prospecto.apellido_materno}.pdf"
    ProspectosMailer.email_a_pdf(current_user.email,nombredelpdf,@prospecto, email).deliver  
      redirect_to :back 
  end

  # POST /prospectos
  # POST /prospectos.json
  def create
    @prospecto = Prospecto.new(params[:prospecto])

    if params[:fromwhere] != nil
      if params[:fromwhere] = 'web'
        if @prospecto.save
          historial = History.new
          historial.model_name = "prospectos"
          historial.model_id = @prospecto.id

          us =  User.where(id: params[:user_id]).first
          if not us.nil?
            historial.user_id = us.id
            historial.role = us.role
          end
          historial.action = "Agregado desde web"
          historial.save

          redirect_to '/web', notice: 'Registro almacenado' 
        end
      end
    else

      @prospecto.user_id=current_user.id
      respond_to do |format|
        if @prospecto.save
          historial = History.new
          historial.model_name = "prospectos"
          historial.model_id = @prospecto.id
          historial.user_id = current_user.id
          historial.role = current_user.role
          historial.action = "Agregado"
          historial.save
          #ProspectosMailer.nuevo_prospecto(@prospecto,current_user.email,current_user.username).deliver
          format.html { redirect_to @prospecto, notice: 'Prospecto was successfully created. #{undo_link}' }
          format.json { render json: @prospecto, status: :created, location: @prospecto }
        else
          flash[:error] = @prospecto.errors.full_messages.to_sentence
          format.html { render action: "new" }
          format.json { render json: @prospecto.errors, status: :unprocessable_entity }
        end
      end


    end

  
  end

  # PUT /prospectos/1
  # PUT /prospectos/1.json
  def update
    @prospecto = Prospecto.find(params[:id])

    respond_to do |format|
      if @prospecto.update_attributes(params[:prospecto])

        format.html { redirect_to @prospecto, notice: "Prospecto was successfully updated. #{undo_link}" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @prospecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prospectos/1
  # DELETE /prospectos/1.json
  def destroy

rol = Role.where(:id=>current_user.role).first
        if rol.nombre == "ACRM" or rol.nombre =="DN" or rol.nombre =="CP"
  
    @prospecto = Prospecto.find(params[:id])
    validado=@prospecto.validado
    @prospecto.destroy
else
  flash[:error] ='No tienes permiso para realizar esta accion'

end
    
   

    
  

    respond_to do |format|
      format.html { redirect_to prospectos_path(:validado=>validado) }
      format.json { head :ok }
    end
  end

  #valida el prospecto
  # POST /prospectos/:id/validar
  def validar
    @prospecto = Prospecto.find(params[:id])
        historial = History.new
        historial.model_name = "prospectos"
        historial.model_id = @prospecto.id
        historial.user_id = current_user.id
        historial.role = current_user.role        
        historial.action = "Validado"
        historial.save      
        @prospecto.validado=true
        @prospecto.importado_revisado=true
        @prospecto.save
        redirect_to edit_prospecto_path(@prospecto,:validado=>"false"), :flash => { :info => "Prospecto validado satisfactoriamente. #{undo_link}" }      
  end

  #convierte el prospecto en solicitante
  # POST /prospectos/:id/convertir
  def convertir
    @prospecto = Prospecto.find(params[:id])
    @prospecto.issolicitante=true
    @prospecto.save

    hasInscritoAlready = Solicitante.where(:prospecto_id=>@prospecto.id).first
    if hasInscritoAlready != nil
      redirect_to edit_solicitante_path(hasInscritoAlready), :flash => { :info => "Prospecto ya habia sido convertido." }
      return
    end

    prospecto=@prospecto
    newsolicitante=Solicitante.create(:prospecto_id=>@prospecto.id)
    newbecacredit=Becacredito.create(:solicitante=>newsolicitante)
    @prospecto.solicitante_id = newsolicitante.id
    @prospecto.save
        historial = History.new
        historial.model_name = "prospectos"
        historial.model_id = @prospecto.id
        historial.user_id = current_user.id
        historial.role = current_user.role        
        historial.action = "Convertido en Solicitante"
        historial.save
    newsolicitante.isexaminado = false
    newsolicitante.archivado = false
    newsolicitante.save
    #new_user = User.new(old_user.attributes.merge(:login => "newlogin"))
    redirect_to edit_solicitante_path(newsolicitante), :flash => { :info => "Prospecto convertido en solicitante satisfactoriamente." }
  end  

  def resumen
      #find prospecto first
      @prospecto = Prospecto.find(params[:id])
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

  end

  def borrarprospectosinvalidos
    prospectosWithNilInUser = Prospecto.where(:user_id=>nil).where(:issolicitante==false)
    prospectosWithNilInUser.destroy_all
    redirect_to purgeprospectos_path
  end

  private
  def undo_link
    view_context.link_to("undo", revert_version_path(@prospecto.versions.scoped.last), :method => :post)
  end  
end
