class DaySerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name
        }
    end
end