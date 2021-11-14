module SerializationConcern
  extend ActiveSupport::Concern

  def render_one(object, serializer_class: nil, status: :ok)
    serializer = serializer_class&.new ||
                 guess_serializer(object.class).new
    json = serializer.serialize_to_json(object)
    render json: json, status: status
  end

  def render_many(resources, serializer_class: nil, status: :ok)
    return render_no_content unless resources.any?

    serializer = Panko::ArraySerializer.new(
      resources,
      each_serializer: serializer_class || guess_serializer(resources.first.class)
    )

    json = serializer.to_json
    render json: json, status: status
  end

  def guess_serializer(klass)
    "#{klass.name}Serializer".constantize
  end
end
