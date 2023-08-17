module ReactComponentConcern
  extend ActiveSupport::Concern

  def render
    component_props
    super
  end

  def component_props; end
end
