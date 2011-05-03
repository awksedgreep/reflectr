class MetricTypesController < ApplicationController
  # GET /metric_types
  # GET /metric_types.xml
  def index
    @metric_types = MetricType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @metric_types }
    end
  end

  # GET /metric_types/1
  # GET /metric_types/1.xml
  def show
    @metric_type = MetricType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @metric_type }
    end
  end

  # GET /metric_types/new
  # GET /metric_types/new.xml
  def new
    @metric_type = MetricType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @metric_type }
    end
  end

  # GET /metric_types/1/edit
  def edit
    @metric_type = MetricType.find(params[:id])
  end

  # POST /metric_types
  # POST /metric_types.xml
  def create
    @metric_type = MetricType.new(params[:metric_type])

    respond_to do |format|
      if @metric_type.save
        format.html { redirect_to(@metric_type, :notice => 'Metric type was successfully created.') }
        format.xml  { render :xml => @metric_type, :status => :created, :location => @metric_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @metric_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /metric_types/1
  # PUT /metric_types/1.xml
  def update
    @metric_type = MetricType.find(params[:id])

    respond_to do |format|
      if @metric_type.update_attributes(params[:metric_type])
        format.html { redirect_to(@metric_type, :notice => 'Metric type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @metric_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_types/1
  # DELETE /metric_types/1.xml
  def destroy
    @metric_type = MetricType.find(params[:id])
    @metric_type.destroy

    respond_to do |format|
      format.html { redirect_to(metric_types_url) }
      format.xml  { head :ok }
    end
  end
end
