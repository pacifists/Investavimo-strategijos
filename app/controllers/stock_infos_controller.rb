class StockInfosController < ApplicationController
  before_action :set_stock_info, only: [:show, :edit, :update, :destroy]

  # GET /stock_infos
  # GET /stock_infos.json
  def index
    @stock_infos = StockInfo.all
  end

  # GET /stock_infos/1
  # GET /stock_infos/1.json
  def show
  end

  # GET /stock_infos/new
  def new
    @stock_info = StockInfo.new
  end

  # GET /stock_infos/1/edit
  def edit
  end

  # POST /stock_infos
  # POST /stock_infos.json
  def create
    @stock_info = StockInfo.new(stock_info_params)

    respond_to do |format|
      if @stock_info.save
        format.html { redirect_to @stock_info, notice: 'Stock info was successfully created.' }
        format.json { render :show, status: :created, location: @stock_info }
      else
        format.html { render :new }
        format.json { render json: @stock_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_infos/1
  # PATCH/PUT /stock_infos/1.json
  def update
    respond_to do |format|
      if @stock_info.update(stock_info_params)
        format.html { redirect_to @stock_info, notice: 'Stock info was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_info }
      else
        format.html { render :edit }
        format.json { render json: @stock_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_infos/1
  # DELETE /stock_infos/1.json
  def destroy
    @stock_info.destroy
    respond_to do |format|
      format.html { redirect_to stock_infos_url, notice: 'Stock info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_info
      @stock_info = StockInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_info_params
      params.require(:stock_info).permit(:stock_id, :stock_date, :open, :high, :low, :close, :adj_close, :volume)
    end
end
