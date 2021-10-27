class IntegrationsController < ApplicationController
  attr_reader :integration

  before_action :set_integration, only: %i[show update destroy]

  # GET /integrations/:id
  def show
    render_one Integration
  end

  # POST /integrations
  def create
    render_one Integration.create!(integration_params), status: :created
  end

  # UPDATE /integrations/:id
  def update
    render_one integration.update!(integration_params), status: :ok
  end

  # DELETE /integrations/:id
  def destroy
    render_one integration.destroy!, status: :ok
  end

  private

  def set_integration
    @integration = Integration.find(params.require(:id))
  end

  def integration_params
    params.require(
      :integration_type # , :user_id
    ).to_h.merge!(
      params[:email],
      params[:metadata],
      params[:name]
    )
  end
end
