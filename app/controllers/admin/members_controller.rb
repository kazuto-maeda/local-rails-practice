class Admin::MembersController < Admin::Base

  def index
    @members = Member.order("number").page(params[:page]).per(15)
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new(birthday: Date.new(1980,1,1))
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to([:admin, @member], notice: "会員情報を登録しました")
    else
      render(:new)
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to([:admin, @member], notice: "会員情報を更新しました" )
    else
      render(:edit)
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to(:admin_members, notice: "会員情報を削除しました")
  end

  def search
    @members = Member.search(params[:q]).page(params[:page]).per(15)
    render "index"
  end

  private

  def member_params
    attr = [:new_profile_picture, :remove_profile_picture, :number, :name, :full_name, :sex, :birthday, :email, :administrator]
    attr << :password if params[:action] == "create"
    params.require(:member).permit(attr)
  end
end
