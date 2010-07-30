class RepliesController < ApplicationController
  before_filter :load_topic
  before_filter :login_required
  before_filter :can_edit_required, :only => [:edit, :update]
  uses_yui_editor
  helper_method :can_edit?
  # GET /replies
  # GET /replies.xml
  def index
    @replies = @topic.replies.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.xml
  def show
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.xml
  def new
    @reply = @topic.replies.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = @topic.replies.find(params[:id])
  end

  # POST /replies
  # POST /replies.xml
  def create
    @reply = @topic.replies.build(params[:reply])
    @reply.user = current_user
    respond_to do |format|
      if @reply.save
        flash[:notice] = '已成功创建回复。'
        format.html { redirect_to([Forum.find(@topic.forum_id), @topic]) }
        format.xml  { render :xml => @reply, :status => :created, :location => @reply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.xml
  def update
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        flash[:notice] = '回复已成功更新。'
        format.html { redirect_to(@topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.xml
  def destroy
    @reply = @topic.replies.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to(@topic) }
      format.xml  { head :ok }
    end
  end

  private
  def load_topic
    @topic = Topic.find(params[:topic_id])
  end
  def can_edit_required
    unless can_edit?
      flash[:notice] = "你不能进行编辑！"
      redirect_to root_url
    end
  end

  def can_edit?
    if is_admin?
      true
    else
      @topic.replies.find(params[:id]).user == current_user ? true : false
    end
  end
end
