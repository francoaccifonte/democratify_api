class VotationsController < ApplicationController
  before_action :set_votation, only: %i[show update]

  # GET /votations/1
  def show; end

  # PATCH/PUT /votations/1
  def update
    if @votation.update(votation_params)
      redirect_to @votation, notice: "Votation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_votation
    @votation = Votation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def votation_params
    params.fetch(:votation, {})
  end
end
