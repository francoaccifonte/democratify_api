module ReactComponentConcern
  extend ActiveSupport::Concern

  # Every controller should define :index_props, :show_props, :create_props, etc
  # Before rendering, this method will be called if it exists and load the props needed for that action
  # A convenience method called `custom_props` can be used if the pattern does not fit in an edge case

  included do
    before_action :initialize_props
  end

  def initialize_props
    @component_props = {}
  end

  def render(*args, **kwargs)
    load_component_props
    super(*args, **kwargs)
  end

  def load_component_props
    @component_props.merge!(
      ongoingPlaylist: serialize_one(@ongoing_playlist),
      votation: serialize_one(@votation)
    )

    add_component_props(send("#{action_name}_props")) if respond_to?("#{action_name}_props", true)

    add_component_props(custom_props)
  end

  def add_component_props(more_props)
    @component_props.merge!(more_props)
  end

  def custom_props
    {}
  end

  def serialized_account(account, _options: {})
    serialize_one(account)
  end
end
