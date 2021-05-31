class TimeTagSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            duration: resource.duration,
            start_at: resource.start_at,
            end_at: resource.end_at
        }
    end

end