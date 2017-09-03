require 'rubygems'
require 'google_chart'
class HomesController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /homes
  # GET /homes.json
  def stweet

  end

  def fetch_dyna
      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_id]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_role]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_sede]
      logger.debug "llllllllllllllllllllllllllllllllllll"    

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:archivado]
      logger.debug "llllllllllllllllllllllllllllllllllll"                 

 archivado = false
      modelo = Configuracione.where(:user_id=>params[:user_id]).first rescue nil
      if modelo != nil
        archivado = modelo.mostrar_archivados
      end

    rol = Role.where(:id=>params[:user_role]).first

     selected = nil

    if rol == nil
      selected =Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
    else
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        selected = Prospecto.where(:archivado=>archivado)
      else
        if rol.nombre == "D" or rol.nombre == "CP"

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede])
        else

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
        end #end director
      end #end else rol nombre
    end #end else nil




      @selected = selected
      
 logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug @selected.size
      logger.debug "llllllllllllllllllllllllllllllllllll"                 



      respond_to do |format|
          format.js
      end
  end

  def fetch_chart
      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_id]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_role]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_sede]
      logger.debug "llllllllllllllllllllllllllllllllllll"    

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:archivado]
      logger.debug "llllllllllllllllllllllllllllllllllll"                 

 archivado = false
      modelo = Configuracione.where(:user_id=>params[:user_id]).first rescue nil
      if modelo != nil
        archivado = modelo.mostrar_archivados
      end

    rol = Role.where(:id=>params[:user_role]).first

     selected = nil

    if rol == nil
      selected =Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
    else
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        selected = Prospecto.where(:archivado=>archivado)
      else
        if rol.nombre == "D" or rol.nombre == "CP"

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede])
        else

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
        end #end director
      end #end else rol nombre
    end #end else nil




      @selected = selected
      @curr = current_user



      respond_to do |format|
          format.js
      end
  end
 def fetch_chart_sede
      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_id]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_role]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_sede]
      logger.debug "llllllllllllllllllllllllllllllllllll"    

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:archivado]
      logger.debug "llllllllllllllllllllllllllllllllllll"                 

 archivado = false
      modelo = Configuracione.where(:user_id=>params[:user_id]).first rescue nil
      if modelo != nil
        archivado = modelo.mostrar_archivados
      end

    rol = Role.where(:id=>params[:user_role]).first

     selected = nil

    if rol == nil
      selected =Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
    else
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        selected = Prospecto.where(:archivado=>archivado)
      else
        if rol.nombre == "D" or rol.nombre == "CP"

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede])
        else

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
        end #end director
      end #end else rol nombre
    end #end else nil




      @selected = selected
      @curr = current_user



      respond_to do |format|
          format.js
      end
  end


 def fetch_chart_sede_usuario
      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_id]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_role]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_sede]
      logger.debug "llllllllllllllllllllllllllllllllllll"    

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:archivado]
      logger.debug "llllllllllllllllllllllllllllllllllll"                 

 archivado = false
      modelo = Configuracione.where(:user_id=>params[:user_id]).first rescue nil
      if modelo != nil
        archivado = modelo.mostrar_archivados
      end

    rol = Role.where(:id=>params[:user_role]).first

     selected = nil

    if rol == nil
      selected =Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
    else
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        selected = Prospecto.where(:archivado=>archivado)
      else
        if rol.nombre == "D" or rol.nombre == "CP"

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede])
        else

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
        end #end director
      end #end else rol nombre
    end #end else nil




      @selected = selected
      @curr = current_user



      respond_to do |format|
          format.js
      end
  end


  def fetch_chart_sede_usuario_hijo
      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_id]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_role]
      logger.debug "llllllllllllllllllllllllllllllllllll"

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:user_sede]
      logger.debug "llllllllllllllllllllllllllllllllllll"    

      logger.debug "llllllllllllllllllllllllllllllllllll"
      logger.debug params[:archivado]
      logger.debug "llllllllllllllllllllllllllllllllllll"                 

 archivado = false
      modelo = Configuracione.where(:user_id=>params[:user_id]).first rescue nil
      if modelo != nil
        archivado = modelo.mostrar_archivados
      end

    rol = Role.where(:id=>params[:user_role]).first

     selected = nil

    if rol == nil
      selected =Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
    else
      if rol.nombre == "DN" or rol.nombre == "ACRM" 
        selected = Prospecto.where(:archivado=>archivado)
      else
        if rol.nombre == "D" or rol.nombre == "CP"

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede])
        else

          selected = Prospecto.where(:archivado=>archivado).where(:sede_id=>params[:user_sede]).where(:user_id=>params[:user_id])
        end #end director
      end #end else rol nombre
    end #end else nil




      @selected = selected
      @curr = User.where(:id=>params[:user_id]).first

      respond_to do |format|
          format.js
      end
  end

  def index
    archivado = false
            rol = Role.where(:id=>current_user.role).first
    modelo = Configuracione.where(:user_id=>user.id).first rescue nil
    
    if modelo != nil
      archivado = modelo.mostrar_archivados
    end   
    
    if rol.nombre == "ACRM"   or rol.nombre == "DN" 
      @prospectosnovalidados=getProspectosForUser(current_user).where(:archivado=>archivado).where(:validado=>false).where(:issolicitante=> false).limit(5)
      @prospectosvalidados=getProspectosForUser(current_user).where(:archivado=>archivado).where(:validado=>true).where(:issolicitante=> false).limit(5)
      @solicitantes=getSolicitantesForUser(current_user).where(:isexaminado=> false).where(:archivado=>archivado).where(:isexaminado=> false).all(:limit=>5)
      @examinados=getExaminadosForUser(current_user).where(:archivado=>archivado).where(:isadmitido=>false).all(:limit=>5)
      @admitidos=getAdmitidosForUser(current_user).where(:archivado=>archivado).where(:isinscrito=>false).all(:limit=>5)
      @inscritos=getInscritosForUser(current_user).where(:archivado=>archivado).all(:limit=>5)

      @tareas =Tarea.where(:user_id =>current_user.id).limit(5).order(:fecha_de_inicio_de_la_tarea)
      @memos=Memo.where(:user_id =>current_user.id).limit(5)
      @llamadas=Llamada.where(:user_id =>current_user.id).limit(5)
    else
      @prospectosnovalidados=getProspectosForUser(current_user).where(:issolicitante=> false).where(:archivado=>archivado).where(:validado=>false).where(:issolicitante=> false).limit(5)
      @prospectosvalidados=getProspectosForUser(current_user).where(:issolicitante=> false).where(:archivado=>archivado).where(:validado=>true).where(:issolicitante=> false).limit(5)
      @solicitantes=getSolicitantesForUser(current_user).where(:isexaminado=> false).where(:archivado=>archivado).where(:isexaminado=> false).all(:limit=>5)
      @examinados=getExaminadosForUser(current_user).where(:archivado=>archivado).where(:isadmitido=>false).all(:limit=>5)
      @admitidos=getAdmitidosForUser(current_user).where(:archivado=>archivado).where(:isinscrito=>false).all(:limit=>5)
      @inscritos=getInscritosForUser(current_user).all(:limit=>5)

      @tareas =Tarea.where(:user_id =>current_user.id).limit(5).order(:fecha_de_inicio_de_la_tarea)
      @memos=Memo.where(:user_id =>current_user.id).limit(5)
      @llamadas=Llamada.where(:user_id =>current_user.id).limit(5)      
    end
#Load facebook.yml info
   #config = YAML::load(File.open("#{Rails.root}/config/facebook.yml"))
  
   #Instantiate a new application with our app_id so we can get an access token
   #my_app = FbGraph::Application.new(config['production']['app_id'])
   #acc_tok = my_app.get_access_token(config['production']['client_secret'])
  
   #Instantiate a new page class using the page_id specified 
   #@page = FbGraph::Page.new('44944396454', :access_token => acc_tok).fetch
   #@searchable = FbGraph::Searchable.search("Coldplay")
   #if session["token"] != nil then
    #begin
     #  @user = FbGraph::User.fetch('anahuacqro', :access_token => session["token"])
       #Grab the events from the page 
      # events = @user.events.sort_by{|e| e.start_time}
       
       #Get the events that are upcoming
       #@upcoming_events = events.find_all{|e| e.start_time >= Time.now}
      
       #Get the events that have passed
       #@past_events = events.find_all{|e| e.start_time < Time.now}.reverse


    #rescue Exception => exc
     #  logger.error("Message for the log file #{exc.message}")
      # flash[:notice] = "No estas logeado en facebook, por favor inicia facebook dando click <b><a href='users/auth/facebook'>aqui</a></b>".html_safe
    #end
  #end

  end

  # GET /homes/1
  # GET /homes/1.json
  def show
    @home = Home.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @home }
    end
  end

  # GET /homes/new
  # GET /homes/new.json
  def new
    @home = Home.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @home }
    end
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(params[:home])

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render json: @home, status: :created, location: @home }
      else
        format.html { render action: "new" }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /homes/1
  # PUT /homes/1.json
  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home = Home.find(params[:id])
    @home.destroy

    respond_to do |format|
      format.html { redirect_to homes_url }
      format.json { head :ok }
    end
  end

def force_redirect
  redirect_to home_path
end

end
