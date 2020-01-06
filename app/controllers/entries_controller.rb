class EntriesController < ApplicationController
  before_action :login_required, except: [:index, :show]

  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end

    @entries = @entries.readable_for(current_member).order(posted_at: :desc).page(params[:page]).per(3)
  end

  def show
    @entry = Entry.readable_for(current_member).find(params[:id])
  end

  def new
    @entry = current_member.entries.build(posted_at: Time.current)
  end

  def create
    @entry = current_member.entries.build(params[:entry])
    if @entry.save
      redirect_to(:entries, notice: "ブログも記事を作成しました")
    else
      render(:edit)
    end
  end

  def edit
    @entry = current_member.entries.find(params[:id])
  end

  def update
    @entry = current_member.entries.find(params[:id])
    @entry.assign_attributes(params[:entry])
    if @entry.save
      redirect_to(:entries, notice: "ブログの記事を更新しました")
    else
      render("edit")
    end
  end

  def destroy
    @entry = current_member.entries.find(params[:id])
    @entry.destroy
    redirect_to(:entries, notice: "ブログの記事を削除しました")
  end
end
