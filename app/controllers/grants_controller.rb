class GrantsController < ApplicationController
  before_action :set_grant, only: [:show, :edit, :update, :destroy]

  rescue_from Apartment::TenantNotFound, with: :tenant_not_found

  # GET /grants
  def index
    @grants = Grant.all
  end

  # GET /grants/1
  def show
  end

  # GET /grants/new
  def new
    @grant = Grant.new
  end

  # GET /grants/1/edit
  def edit
  end

  # POST /grants
  def create
    @grant = Grant.new(grant_params)

    if @grant.save
      redirect_to @grant, notice: 'Grant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /grants/1
  def update
    if @grant.update(grant_params)
      redirect_to @grant, notice: 'Grant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grants/1
  def destroy
    @grant.destroy
    redirect_to grants_url, notice: 'Grant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant
      @grant = Grant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_params
      params.require(:grant).permit(:program_title, :institution, :department, :program_description, :subdomain)
    end


    def tenant_not_found
        render 'lvh.me:3000'
    end
end
