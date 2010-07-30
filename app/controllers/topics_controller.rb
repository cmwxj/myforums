class TopicsController < ApplicationController
  before_filter :login_required
  before_filter :load_forum
  before_filter :can_edit_required, :only => [:edit, :update]
  uses_yui_editor(:only => [:show, :edit, :create])
  helper_method :can_edit?
  #uses_yui_editor
  # GET /topics
  # GET /topics.xml
  def index
    @topics = @forum.topics

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = @forum.topics.find(params[:id])
    @replies = @topic.replies.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = @forum.topics.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = @forum.topics.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = @forum.topics.build(params[:topic])
    @topic.user = current_user
    respond_to do |format|
      if @topic.save
        flash[:notice] = '主题已成功创建。'
        format.html { redirect_to(@forum) }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = @forum.topics.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = '主题已成功更新。'
        format.html { redirect_to(@forum) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = @forum.topics.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topics_url(@forum)) }
      format.xml  { head :ok }
    end
  end
  private
  def load_forum
    @forum = Forum.find(params[:forum_id])
  end

  def can_edit_required
    unless can_edit?
      flash[:notice] = "你不能进行编辑。"
      redirect_to root_url
    end
  end

  def can_edit?
    if is_admin?
      true
    else
      @forum.topics.find(params[:id]).user == current_user ? true : false
    end  
  end
end
