class FichasController < ApplicationController
 
before_filter :load_professors
require_role ["admin","planejamento"], :for => [:update,:destroy,:new,:create,:edit] # don't allow contractors to destroy
layout 'ficha'
  # GET /fichas
  # GET /fichas.xml
  def index
    
    @fichas = @professor.fichas.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fichas }
    end
  end

  # GET /fichas/1
  # GET /fichas/1.xml
  def show
    @ficha = @professor.fichas.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf {
        html = render_to_string(:layout => false , :action => "show.html.haml")
        kit = PDFKit.new(html)
        kit.stylesheets << "#{Rails.root}/public/stylesheets/ficha.css"
        send_data(kit.to_pdf, :filename => "#{@ficha.id}.pdf", :type => 'application/pdf')
        return # to avoid double render call
        }
    end

  end



  # DELETE /fichas/1
  # DELETE /fichas/1.xml
  def destroy
    @ficha = @professor.fichas.find(params[:id])
    @ficha.destroy

    respond_to do |format|
      format.html { redirect_to relatorio_ficha_path }
      format.xml  { head :ok }
    end
  end


  protected

  def load_professors
    @professor = Professor.find(params[:professor_id], :include => :fichas)
  end
end
