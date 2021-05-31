class RoomCategorySerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            rooms: RoomSerializer.new( resource.rooms ).serialize
        }

    end

end