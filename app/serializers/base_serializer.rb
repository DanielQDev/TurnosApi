class BaseSerializer < Panko::Serializer
  def collection_parser(collection, serializer, attributes = [], context = {})
    JSON.parse(
      Panko::ArraySerializer.new(
        collection,
        each_serializer: serializer,
        only: {instance: attributes},
        context: context
      ).to_json
    )
  end
end