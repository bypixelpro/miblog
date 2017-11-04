class ArticulosController < ApplicationController

  before_action :authenticate_autor!, except: [:index, :show]
  before_action :correct_autor, only: [:edit, :update, :destroy]
  
  def index
    #Array que recoge todos los artículos
    @articulos=Articulo.all.order("created_at DESC")
  end

  def new
    #Lo guardamos en memoria
   # @articulo= Articulo.new
   @boton = "Crear"
   @articulo= current_autor.articulos.build
    
  end

  def create
    #volvemos a crear la variable de instancia y recogemos los parametros
    #params en rails es un hash que almacena todos los parametros,
    #tanto get como post. En realizad la variable es asi: params:articulo
    #pero esto es peligroso ya que permite pasar cualquier tipo, esto hace
    #vulnerable nuestra base de datos. De esta otra, lo hacemos con strong params + seguro
    @articulo= current_autor.articulos.build(articulo_params)
    #si guarda bien, le redirigimos
    if @articulo.save
      redirect_to @articulo
    else
      render 'new'#viuelve a mostrar la vista del formulario
    end
    
  end

  def edit
    @boton = "Editar"
    @articulo=Articulo.find(params[:id])
    
  end

  def  update
    @articulo=Articulo.find(params[:id])
    if @articulo.update(articulo_params)

      flash[:notice] = "Artículo modificado correctamente!"

      redirect_to @articulo
    else
      render 'edit'
    end
  end

  def show
    @articulo=Articulo.find(params[:id])
  end
  
  def destroy
    @articulo=Articulo.find(params[:id])
    @articulo.destroy
    redirect_to articulos_path
    flash[:notice] = "Artículo eliminado correctamente!"
    
  end 

  #Una vez creado el articulos params, definimos el método
  private
  def articulo_params
    #primero parametros obligatorios y luego los permitidos asi controlamos lo que entra
    params.require(:articulo).permit(:titulo, :contenido)
  end
  #fin

  def correct_autor
    @articulo = current_autor.articulos.find_by(id: params[:id])
    redirect_to articulos_path, flash[:notice] = "Tu no puedes tocar esto" if@articulo.nil?
  end
end
