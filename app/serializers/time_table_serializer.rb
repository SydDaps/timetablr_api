class TimeTableSerializer < BaseSerializer
    def serialize_single(resource, _)
        {
            id: resource.id,
            name: resource.name,
            kind: resource.kind,
            status: resource.status,
            days: DaySerializer.new(resource.days).serialize
        }
    end

end