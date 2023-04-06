module SerializationConcern
  extend ActiveSupport::Concern

  def render_one(object, serializer_class: nil, status: :ok, options: {})
    return render_no_content if object.blank?

    serializer = serializer_class&.new(**options) ||
                 guess_serializer(object.class).new(**options)
    json = serializer.serialize_to_json(object)
    render json:, status:
  end

  def render_many(resources, serializer_class: nil, status: :ok, options: {})
    return render_no_content unless resources.any?

    serializer = Panko::ArraySerializer.new(
      resources,
      **options.merge(each_serializer: serializer_class || guess_serializer(resources.first.class))
    )

    json = serializer.to_json
    render json:, status:
  end

  def render_no_content
    render json: {}, status: :no_content
  end

  private

  def guess_serializer(klass)
    "#{klass.name}Serializer".constantize
  end
end
