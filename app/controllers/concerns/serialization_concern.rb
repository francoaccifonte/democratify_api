module SerializationConcern
  extend ActiveSupport::Concern

  def render_one(object, serializer_class: nil, status: :ok, options: {})
    return render_no_content if object.blank?

    render json: serialize_one(object, options:, serializer_class:), status:
  end

  def render_many(resources, serializer_class: nil, status: :ok, options: {})
    return render_no_content unless resources.any?

    render json: serialize_many(resources, options:, serializer_class:), status:
  end

  def render_no_content
    render json: {}, status: :no_content
  end

  def serialize_one(object, options: {}, serializer_class: nil)
    return nil if object.nil?

    serializer = serializer_class&.new(**options) ||
                 guess_serializer(object.class).new(**options)
    serializer.serialize_to_json(optimized_object(object, serializer))
  end

  def serialize_many(resources, options: {}, serializer_class: nil)
    return [] unless resources.any?

    Panko::ArraySerializer.new(
      resources,
      **options.merge(each_serializer: serializer_class || guess_serializer(resources.first.class))
    ).to_json
  end

  private

  def guess_serializer(klass)
    "#{klass.name}Serializer".constantize
  end

  def optimized_object(object, serializer)
    ActiveRecord::Base.logger = Logger.new(STDOUT)
    return object unless serializer.class.respond_to?(:performant_query)

    byebug
    serializer.class.performant_query.find(object.id)
  end
end
