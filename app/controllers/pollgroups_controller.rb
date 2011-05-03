class PollgroupsController < ApplicationController
  # GET /pollgroups
  # GET /pollgroups.xml
  def index
    @pollgroups = Pollgroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pollgroups }
    end
  end

  # GET /pollgroups/1
  # GET /pollgroups/1.xml
  def show
    @pollgroup = Pollgroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pollgroup }
    end
  end

  # GET /pollgroups/new
  # GET /pollgroups/new.xml
  def new
    @pollgroup = Pollgroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pollgroup }
    end
  end

  # GET /pollgroups/1/edit
  def edit
    @pollgroup = Pollgroup.find(params[:id])
  end

  # POST /pollgroups
  # POST /pollgroups.xml
  def create
    @pollgroup = Pollgroup.new(params[:pollgroup])

    respond_to do |format|
      if @pollgroup.save
        format.html { redirect_to(@pollgroup, :notice => 'Pollgroup was successfully created.') }
        format.xml  { render :xml => @pollgroup, :status => :created, :location => @pollgroup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pollgroup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pollgroups/1
  # PUT /pollgroups/1.xml
  def update
    @pollgroup = Pollgroup.find(params[:id])

    respond_to do |format|
      if @pollgroup.update_attributes(params[:pollgroup])
        format.html { redirect_to(@pollgroup, :notice => 'Pollgroup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pollgroup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pollgroups/1
  # DELETE /pollgroups/1.xml
  def destroy
    @pollgroup = Pollgroup.find(params[:id])
    @pollgroup.destroy

    respond_to do |format|
      format.html { redirect_to(pollgroups_url) }
      format.xml  { head :ok }
    end
  end
end
