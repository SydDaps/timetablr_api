class RoomSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            capacity: resource.capacity,
            time_tags: TimeTagSerializer.new( resource.time_tags  ).serialize
        }

    end

end