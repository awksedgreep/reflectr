class CurrentStatsController < ApplicationController
  # GET /current_stats
  # GET /current_stats.xml
  def index
    @current_stats = CurrentStat.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @current_stats }
    end
  end

  # GET /current_stats/1
  # GET /current_stats/1.xml
  def show
    @current_stat = CurrentStat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @current_stat }
    end
  end

  # GET /current_stats/new
  # GET /current_stats/new.xml
  def new
    @current_stat = CurrentStat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @current_stat }
    end
  end

  # GET /current_stats/1/edit
  def edit
    @current_stat = CurrentStat.find(params[:id])
  end

  # POST /current_stats
  # POST /current_stats.xml
  def create
    @current_stat = CurrentStat.new(params[:current_stat])

    respond_to do |format|
      if @current_stat.save
        format.html { redirect_to(@current_stat, :notice => 'Current stat was successfully created.') }
        format.xml  { render :xml => @current_stat, :status => :created, :location => @current_stat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @current_stat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /current_stats/1
  # PUT /current_stats/1.xml
  def update
    @current_stat = CurrentStat.find(params[:id])

    respond_to do |format|
      if @current_stat.update_attributes(params[:current_stat])
        format.html { redirect_to(@current_stat, :notice => 'Current stat was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @current_stat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /current_stats/1
  # DELETE /current_stats/1.xml
  def destroy
    @current_stat = CurrentStat.find(params[:id])
    @current_stat.destroy

    respond_to do |format|
      format.html { redirect_to(current_stats_url) }
      format.xml  { head :ok }
    end
  end
end
