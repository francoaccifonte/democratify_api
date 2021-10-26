module SerializationConcern
  extend ActiveSupport::Concern

  def render_one(object, serializer_class: nil, status: :ok)
    serializer = serializer_class&.new ||
                 guess_serializer(object.class).new
    json = serializer.serialize_to_json(object)
    render json: json, status: status
  end

  def render_many(objects, serializer_class: nil, status: :ok)
    serializer = serializer_class&.new(objects) || guess_serializer(objects.first.class).new(objects)
    json = serializer.serializable_hash
    render json: json, status: status
  end

  def guess_serializer(klass)
    "#{klass.name}Serializer".constantize
  end
end
